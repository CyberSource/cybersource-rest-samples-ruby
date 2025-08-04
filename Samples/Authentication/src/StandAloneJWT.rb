require 'base64'
require 'openssl'
require 'jwt'
require 'json'
require 'date'
require 'net/http'
require 'net/http/persistent'
require 'addressable/uri'
require 'active_support'
require 'time'

public
class StandAloneJWT
  # Initialization of constant data
  # Try with your own credentaials
  # Get Key ID, Secret Key and Merchant Id from EBC portal
  @@request_host = "apitest.cybersource.com"
  @@merchant_id = "testrest"
  @@merchant_key_id = "08c94330-f618-42a3-b09d-e1e43be5efda"
  @@merchant_secret_key = "yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE="
  @@filename = "testrest"
  @@payload = "{" +
        "  \"clientReferenceInformation\": {" +
        "    \"code\": \"TC50171_3\"" +
        "  }," +
        "  \"processingInformation\": {" +
        "    \"commerceIndicator\": \"internet\"" +
        "  }," +
        "  \"orderInformation\": {" +
        "    \"billTo\": {" +
        "      \"firstName\": \"john\"," +
        "      \"lastName\": \"doe\"," +
        "      \"address1\": \"201 S. Division St.\"," +
        "      \"postalCode\": \"48104-2201\"," +
        "      \"locality\": \"Ann Arbor\"," +
        "      \"administrativeArea\": \"MI\"," +
        "      \"country\": \"US\"," +
        "      \"phoneNumber\": \"999999999\"," +
        "      \"email\": \"test@cybs.com\"" +
        "    }," +
        "    \"amountDetails\": {" +
        "      \"totalAmount\": \"10\"," +
        "      \"currency\": \"USD\"" +
        "    }" +
        "  }," +
        "  \"paymentInformation\": {" +
        "    \"card\": {" +
        "      \"expirationYear\": \"2031\"," +
        "      \"number\": \"5555555555554444\"," +
        "      \"securityCode\": \"123\"," +
        "      \"expirationMonth\": \"12\"," +
        "      \"type\": \"002\"" +
        "    }" +
        "  }" +
        "}"

  # HTTP Persistent connection configuration
  @@keep_alive_timeout = 1 # seconds
  @@connection_pool_size = 5
  # Initialize persistent HTTP client
  @@http_persistent = Net::HTTP::Persistent.new(name: 'cybersource_api')

  @@default_headers = {}

  def initialize
    # Configure persistent connection settings
    @@http_persistent.idle_timeout = @@keep_alive_timeout
    # @@http_persistent.pool_size = @@connection_pool_size
    @@http_persistent.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  # Function to get the Json Web Token
  # param: resource - denotes the resource being accessed
  # param: http_method - denotes the HTTP verb
  # param: gmtdatetime - stores the current timestamp
  def getJsonWebToken(resource, http_method, gmtdatetime)
    jwtBody = ''
    filePath = File.join(File.dirname(__FILE__), "../resource/" + @@filename + ".p12")

    p12File = File.binread(filePath)

    if http_method == "post"
        payload = @@payload
        digest = Digest::SHA256.base64digest(payload)
        jwtBody = "{\"digest\":\"" + digest + "\", \"digestAlgorithm\":\"SHA-256\", \"iat\": "+ Time.parse(gmtdatetime).to_i.to_s + "}"
    elsif http_method == "get"
         jwtBody = "{\n \"iat\":" + Time.parse(gmtdatetime).to_i.to_s + "\n} \n\n"
    end

    claimSet = JSON.parse(jwtBody)
    p12FilePath = OpenSSL::PKCS12.new(p12File, "testrest")

    publicKey = OpenSSL::PKey::RSA.new(p12FilePath.key.public_key)
    privateKey = OpenSSL::PKey::RSA.new(p12FilePath.key)
    x5CertPem = OpenSSL::X509::Certificate.new(p12FilePath.certificate)
    x5CertDer = Base64.strict_encode64(x5CertPem.to_der)

    x5clist = [x5CertDer]

    customHeaders = {}
    customHeaders['v-c-merchant-id'] = @@merchant_id
    customHeaders['x5c'] = x5clist

    token = JWT.encode(claimSet, privateKey, 'RS256', customHeaders)

    puts "\n -- TOKEN --\n"
    puts token;

    return token
  end

  def processPost()
    resource = "/pts/v2/payments/"
    method = "post"
    statusCode = -1
    url = Addressable::URI.encode("https://" + @@request_host + resource)
    uri = Addressable::URI.parse(url)

    header_params = {}
    header_params['Accept'] = 'application/hal+json;charset=utf-8'
    header_params['Content-Type'] = 'application/json;charset=utf-8'

    auth_names = []
    gmtDateTime = DateTime.now.httpdate

    # puts "\n -- RequestURL -- \n"
    # puts "\tURL : " + url + "\n"
    # puts "\n -- HTTP Headers -- \n"
    # puts "\tContent-Type : application/json;charset=utf-8" + "\n"
    # puts "\tv-c-merchant-id : " + @@merchant_id + "\n"
    # puts "\tDate : " + gmtDateTime + "\n"
    # puts "\tHost : " + @@request_host + "\n"

    token = "Bearer " + getJsonWebToken(resource, method, gmtDateTime)

    header_params['Authorization'] = token

    header_params['v-c-merchant-id'] = @@merchant_id
    header_params['Date'] = gmtDateTime
    header_params['Host'] = @@request_host

    payload = @@payload
    digest = Digest::SHA256.base64digest(payload)
    digest_payload = 'SHA-256=' + digest
    header_params['Digest'] = digest_payload

    headers = @@default_headers.merge(header_params || {})

    # Create a POST request for persistent HTTP client
    5.times do |i|
      sleep(6)
      req = Net::HTTP::Post.new(uri.request_uri)
      req.body = @@payload
      header_params.each do |custom_header, custom_header_value|
          req[custom_header] = custom_header_value
      end

      # Execute the request with persistent connection
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
      response = @@http_persistent.request(uri, req)
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :nanosecond)
      time_taken = (end_time - start_time) / 1_000_000 # ms
      if response.code.to_i >= 200 && response.code.to_i <= 299
          statusCode = 0
      else
          statusCode = -1
      end
      if statusCode == 0
        puts "Call #{i+1} STATUS : SUCCESS took #{time_taken} to complete."
      else
        puts "Call #{i+1} STATUS : ERROR"
      end
    end


    # puts "\n -- Response Message -- \n"
    # puts "\tResponse Code : " + response.code + "\n"
    # puts "\tv-c-correlation-id : " + response['v-c-correlation-id'] + "\n"
    # puts "\n"
    # puts "\tResponse Data :\n"
    # puts response.body + "\n\n"

    return statusCode;
  end

  def processGet()
    resource = "/reporting/v3/reports?startTime=2021-02-01T00:00:00.0Z&endTime=2021-02-02T23:59:59.0Z&timeQueryType=executedTime&reportMimeType=application/xml"
    method = "get"
    statusCode = -1
    url = Addressable::URI.encode("https://" + @@request_host + resource)
    uri = Addressable::URI.parse(url)

    header_params = {}
    header_params['Accept'] = 'application/hal+json;charset=utf-8'
    header_params['Content-Type'] = 'application/json;charset=utf-8'

    auth_names = []
    gmtDateTime = DateTime.now.httpdate

    puts "\n -- RequestURL -- \n"
    puts "\tURL : " + url + "\n"
    puts "\n -- HTTP Headers -- \n"
    puts "\tContent-Type : application/json;charset=utf-8" + "\n"
    puts "\tv-c-merchant-id : " + @@merchant_id + "\n"
    puts "\tDate : " + gmtDateTime + "\n"
    puts "\tHost : " + @@request_host + "\n"

    token = "Bearer " + getJsonWebToken(resource, method, gmtDateTime)

    header_params['Authorization'] = token

    header_params['v-c-merchant-id'] = @@merchant_id
    header_params['Accept-Encoding'] = '*'
    header_params['Date'] = gmtDateTime
    header_params['Host'] = @@request_host
    header_params['User-Agent'] = "Mozilla/5.0"

    headers = @@default_headers.merge(header_params || {})

    # Create a GET request for persistent HTTP client
    request_uri = uri.request_uri
    req = Net::HTTP::Get.new(request_uri)
    
    header_params.each do |custom_header, custom_header_value|
        req[custom_header] = custom_header_value
    end

    # Execute the request with persistent connection
    response = @@http_persistent.request(uri, req)

    if response.code.to_i >= 200 && response.code.to_i <= 299
        statusCode = 0
    end

    puts "\n -- Response Message -- \n"
    puts "\tResponse Code : " + response.code + "\n"
    puts "\tv-c-correlation-id : " + response['v-c-correlation-id'] + "\n"

    puts "\n"
    puts "\tResponse Data :\n"
    puts response.body + "\n\n"

    return statusCode;
  end

  def cleanup
    # Close the persistent connection when done
    @@http_persistent.shutdown
  end

  def write_log_audit(status)
    filename = ($0.split("/")).last.split(".")[0]
    puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  def main
    # HTTP POST REQUEST
    puts "\n\nSample 1: POST call - CyberSource Payments API - HTTP POST Payment request"
    @statusCode = processPost()
    statusCodePost = @statusCode

    if @statusCode == 0
        puts "STATUS : SUCCESS (HTTP Status = #@statusCode)"
    else
        puts "STATUS : ERROR (HTTP Status = #@statusCode)"
    end

    # HTTP GET REQUEST
    # puts "\n\nSample 2: GET call - CyberSource Reporting API - HTTP GET Reporting request"
    # @statusCode = processGet()
    # statusCodeGet = @statusCode

    # if @statusCode == 0
    #     puts "STATUS : SUCCESS (HTTP Status = #@statusCode)"
    # else
    #     puts "STATUS : ERROR (HTTP Status = #@statusCode)"
    # end

    # if statusCodePost == 0 and statusCodeGet == 0
    #     write_log_audit(200)
    # else
    #     write_log_audit(400)
    # end
    
    # Clean up connections when done
    cleanup
  end

  if __FILE__ == $0
    StandAloneJWT.new.main
  end
end
