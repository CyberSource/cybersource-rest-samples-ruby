# START GENAI
#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Multithreaded performance test for CyberSource Stand-Alone JWT example.
#   gem install jwt addressable net-http-persistent
#

require 'base64'
require 'openssl'
require 'jwt'
require 'json'
require 'digest'
require 'net/http'
require 'net/http/persistent'
require 'addressable/uri'
require 'time'
require 'thread'

########################################
# CYBERSOURCE  STAND-ALONE  JWT CLIENT
########################################
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

  # ---------------------------------------------------------------
  # ONE global persistent connection pool shared by **all** threads
  # ---------------------------------------------------------------
  HTTP_POOL = Net::HTTP::Persistent.new(name: 'cybersource_pool').tap do |http|
    http.idle_timeout = 300
    http.verify_mode  = OpenSSL::SSL::VERIFY_PEER
  end

  # ---------------------------------------------------------------
  # Parse the PKCS#12 just once – keeps it thread-safe and fast
  # ---------------------------------------------------------------
  PKCS12       = OpenSSL::PKCS12.new(File.binread(P12_FILE), 'testrest')
  PRIVATE_KEY  = PKCS12.key
  CERT_DER_B64 = Base64.strict_encode64(PKCS12.certificate.to_der)

  # ----------------------------------------------------------------
  # Build & sign a JWT
  # ----------------------------------------------------------------
  def json_web_token(resource, http_method, http_date)
    body =
      if http_method == :post
        {
          digest: Digest::SHA256.base64digest(JSON_PAYLOAD),
          digestAlgorithm: 'SHA-256',
          iat: Time.httpdate(http_date).to_i
        }
      else
        { iat: Time.httpdate(http_date).to_i }
      end

    header = {
      'v-c-merchant-id' => MERCHANT_ID,
      'x5c'             => [CERT_DER_B64]
    }

    JWT.encode(body, PRIVATE_KEY, 'RS256', header)
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

    req       = Net::HTTP::Post.new(uri.request_uri)
    req.body  = JSON_PAYLOAD
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

    [(resp.code || 0).to_i, (t1 - t0) / 1_000_000.0]
  rescue StandardError => e
    warn "Thread #{Thread.current.object_id}: #{e.class} - #{e.message}"
    [0, -1.0] # indicate error
  end
end

#####################################
# PARALLEL  TEST  DRIVER
#####################################
THREAD_COUNT     = 10   # concurrent threads
CALLS_PER_THREAD = 1    # calls each thread makes

mutex      = Mutex.new
latencies  = []          # stores every latency (ms)
status_cnt = Hash.new(0) # histogram of HTTP status codes

jwt_client = StandAloneJWT.new   # ONE shared client

threads = []

threads << Thread.new do
  CALLS_PER_THREAD.times do |call_idx|
    status, latency = jwt_client.do_one_payment
    lat_str = latency.negative? ? 'ERR' : format('%.1f', latency)

    puts "T1-#{call_idx}: status=#{status} latency=#{lat_str} ms"
    mutex.synchronize do
      latencies << latency if latency.positive?
      status_cnt[status] += 1
    end
  end
end

sleep 120 # Wait for 120 seconds before starting the second thread

threads << Thread.new do
  CALLS_PER_THREAD.times do |call_idx|
    status, latency = jwt_client.do_one_payment
    lat_str = latency.negative? ? 'ERR' : format('%.1f', latency)

    puts "T2-#{call_idx}: status=#{status} latency=#{lat_str} ms"
    mutex.synchronize do
      latencies << latency if latency.positive?
      status_cnt[status] += 1
    end
  end
end

threads.each(&:join)

#####################################
# SIMPLE  STATISTICS
#####################################
unless latencies.empty?
  avg = latencies.sum / latencies.size
  puts "
----- SUMMARY -----"
  puts "Total calls      : #{latencies.size}"
  puts "Average latency  : #{format('%.1f', avg)} ms"
  puts "Min / Max        : #{format('%.1f', latencies.min)} / #{format('%.1f', latencies.max)} ms"
end

puts "
Status histogram:"
status_cnt.sort.each { |code, cnt| puts "  #{code} : #{cnt}" }

# If you want an explicit shutdown:
# StandAloneJWT::HTTP_POOL.shutdown

# END GENAI