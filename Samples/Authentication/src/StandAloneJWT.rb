# START GENAI
#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Multithreaded performance test for CyberSource Stand-Alone JWT example.
#
# Gems that are not part of std-lib:
#   gem install jwt addressable net-http-persistent
#

require 'base64'
require 'openssl'
require 'jwt'
require 'json'
require 'date'
require 'net/http'
require 'net/http/persistent'
require 'addressable/uri'
require 'time'
require 'thread'

##############################
# THE ORIGINAL SAMPLE – trimmed
##############################
class StandAloneJWT
  REQUEST_HOST        = 'apitest.cybersource.com'
  MERCHANT_ID         = 'testrest'
  MERCHANT_KEY_ID     = '08c94330-f618-42a3-b09d-e1e43be5efda'
  MERCHANT_SECRET_KEY = 'yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE='
  P12_FILE            = File.expand_path('../resource/testrest.p12', __dir__)

  JSON_PAYLOAD = <<~PAYLOAD
  {
    "clientReferenceInformation": {
      "code": "TC50171_3"
    },
    "processingInformation": {
      "commerceIndicator": "internet"
    },
    "orderInformation": {
      "billTo": {
        "firstName": "john",
        "lastName": "doe",
        "address1": "201 S. Division St.",
        "postalCode": "48104-2201",
        "locality": "Ann Arbor",
        "administrativeArea": "MI",
        "country": "US",
        "phoneNumber": "999999999",
        "email": "test@cybs.com"
      },
      "amountDetails": {
        "totalAmount": "10",
        "currency": "USD"
      }
    },
    "paymentInformation": {
      "card": {
        "expirationYear": "2031",
        "number": "5555555555554444",
        "securityCode": "123",
        "expirationMonth": "12",
        "type": "002"
      }
    }
  }
  PAYLOAD

  # ------------------------------------------------------------------
  # ONE global persistent connection pool that is shared by all
  # threads.  The library is thread-safe.
  # ------------------------------------------------------------------
  HTTP_POOL = Net::HTTP::Persistent.new(name: 'cybersource_pool').tap do |http|
    http.idle_timeout = 300
    http.verify_mode  = OpenSSL::SSL::VERIFY_PEER
  end

  # ------------------------------------------------------------------
  # Build & sign a JWT
  # ------------------------------------------------------------------
  def json_web_token(resource, http_method, http_date)
    body_json =
      if http_method == :post
        digest = Digest::SHA256.base64digest(JSON_PAYLOAD)
        { digest: digest, digestAlgorithm: 'SHA-256', iat: Time.httpdate(http_date).to_i }
      else
        { iat: Time.httpdate(http_date).to_i }
      end

    # material from the .p12
    pkcs12      = OpenSSL::PKCS12.new(File.binread(P12_FILE), 'testrest')
    private_key = pkcs12.key
    cert_der    = Base64.strict_encode64(pkcs12.certificate.to_der)

    header = {
      'v-c-merchant-id' => MERCHANT_ID,
      'x5c'             => [cert_der]
    }

    JWT.encode(body_json, private_key, 'RS256', header)
  end

  # -------------------------------------------------------------
  # Perform ONE payment call and return [http_status, latency_ms]
  # -------------------------------------------------------------
  def do_one_payment
    resource     = '/pts/v2/payments'
    uri          = Addressable::URI.parse("https://#{REQUEST_HOST}#{resource}")
    now_httpdate = Time.now.httpdate

    token      = "Bearer #{json_web_token(resource, :post, now_httpdate)}"
    digest_hdr = 'SHA-256=' + Digest::SHA256.base64digest(JSON_PAYLOAD)

    req = Net::HTTP::Post.new(uri.request_uri)
    req.body = JSON_PAYLOAD

    req['Accept']          = 'application/hal+json;charset=utf-8'
    req['Content-Type']    = 'application/json;charset=utf-8'
    req['Authorization']   = token
    req['v-c-merchant-id'] = MERCHANT_ID
    req['Date']            = now_httpdate
    req['Host']            = REQUEST_HOST
    req['Digest']          = digest_hdr

    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
    resp = HTTP_POOL.request(uri, req)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)

    latency_ms = (t1 - t0) / 1_000_000.0
    [resp.code.to_i, latency_ms]
  rescue StandardError => e
    warn "Thread #{Thread.current.object_id}: #{e.class} - #{e.message}"
    [0, -1.0] # indicate error
  end
end

#####################################
# PARALLEL TEST DRIVER STARTS HERE
#####################################

THREAD_COUNT       = 10   # how many concurrent threads
CALLS_PER_THREAD   = 5    # how many calls each thread makes

mutex      = Mutex.new
latencies  = []          # will hold every latency measurement (ms)
status_cnt = Hash.new(0) # counts per HTTP status

threads = Array.new(THREAD_COUNT) do |tindex|
  Thread.new do
    client = StandAloneJWT.new

    CALLS_PER_THREAD.times do |call_idx|
      status, latency = client.do_one_payment
      latency_ms_str  = latency.negative? ? 'ERR' : format('%0.1f', latency)

      puts "T#{tindex}-#{call_idx}: status=#{status} latency=#{latency_ms_str} ms"
      mutex.synchronize do
        latencies  << latency if latency.positive?
        status_cnt[status] += 1
      end
    end
  end
end

threads.each(&:join)

#####################################
#  SIMPLE  STATISTICS
#####################################
unless latencies.empty?
  avg = latencies.sum / latencies.size
  puts "
----- SUMMARY -----"
  puts "Total calls      : #{latencies.size}"
  puts "Average latency  : #{'%.1f' % avg} ms"
  puts "Min / Max        : #{'%.1f' % latencies.min} / #{'%.1f' % latencies.max} ms"
end

puts "
Status histogram:"
status_cnt.sort.each { |code, cnt| puts "  #{code} : #{cnt}" }

# The Net::HTTP::Persistent pool will automatically clean up idle connections
# when the process finishes.  If you want an explicit shutdown, you can do:
#   StandAloneJWT::HTTP_POOL.shutdown

# END GENAI