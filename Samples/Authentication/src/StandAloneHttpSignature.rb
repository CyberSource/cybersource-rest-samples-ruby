require 'digest'
require 'openssl'
require 'date'
require 'uri'
require 'base64'
require 'json'
require 'net/http'

public 
class StandAloneHttpSignature
  # Initialization of constant data
  # Try with your own credentaials
  # Get Key ID, Secret Key and Merchant Id from EBC portal
  @@request_host = "apitest.cybersource.com"
  @@merchant_id = "testrest"
  @@merchant_key_id = "08c94330-f618-42a3-b09d-e1e43be5efda"
  @@merchant_secret_key = "yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE="
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

  @@default_headers = {}

  # Function to get the HTTP signature
  # param: resource - denotes the resource being accessed
  # param: http_method - denotes the HTTP verb
  # param: gmtdatetime - stores the current timestamp
  def getHttpSignature(resource, http_method, gmtdatetime)
    signatureHeaderValue = ''
    signatureHeader = ''
    signatureHeaderValue << "keyid=\"" + @@merchant_key_id + "\""
    signatureHeaderValue << ", algorithm=\"HmacSHA256\""
    
    if http_method == "post"
        signatureHeader = 'host date (request-target) digest v-c-merchant-id'
    elsif http_method == "get"
        signatureHeader = 'host date (request-target) v-c-merchant-id'
    end
    
    signatureHeaderValue << ", headers=\"" + signatureHeader + "\""
    
    signatureString = 'host: ' + @@request_host
    signatureString << "\ndate: " + gmtdatetime
    signatureString << "\n(request-target): "
    
    targetUrl = http_method + ' ' + resource
    
    signatureString << targetUrl

    if http_method == "post"
        payload = @@payload
        digest = Digest::SHA256.base64digest(payload)
        digest_payload = 'SHA-256=' + digest
        signatureString << "\ndigest: " + digest_payload
    end
    
    signatureString << "\nv-c-merchant-id: " + @@merchant_id
    
    encodedSignatureString = signatureString.force_encoding(Encoding::UTF_8)
    decodedKey = Base64.decode64(@@merchant_secret_key)
    base64EncodedSignature = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', decodedKey, encodedSignatureString))
    
    signature_value = base64EncodedSignature
    
    signatureHeaderValue << ", signature=\"" + signature_value + "\""
    
    return signatureHeaderValue
  end
  
  def processPost()
    resource = "/pts/v2/payments/"
    method = "post"
    statusCode = -1
    url = URI.encode("https://" + @@request_host + resource)
    
    header_params = {}
    header_params['Accept'] = 'application/hal+json;charset=utf-8'
    header_params['Content-Type'] = 'application/json;charset=utf-8'
    
    auth_names = []
    gmtDateTime = DateTime.now.httpdate
    
    token = getHttpSignature(resource, method, gmtDateTime)
    
    header_params['v-c-merchant-id'] = @@merchant_id
    header_params['Date'] = gmtDateTime
    header_params['Host'] = @@request_host
    header_params['Signature'] = token
    
    payload = @@payload
    digest = Digest::SHA256.base64digest(payload)
    digest_payload = 'SHA-256=' + digest
    header_params['Digest'] = digest_payload

    headers = @@default_headers.merge(header_params || {})

    puts "\n -- RequestURL -- \n"
    puts "\tURL : " + url + "\n"
    puts "\n -- HTTP Headers -- \n"
    puts "\tContent-Type : application/json;charset=utf-8" + "\n"
    puts "\tv-c-merchant-id : " + @@merchant_id + "\n"
    puts "\tDate : " + gmtDateTime + "\n"
    puts "\tHost : " + @@request_host + "\n"
	puts "\tSignature : " + token + "\n"
	puts "\tDigest : " + digest + "\n"
    
    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.body = @@payload
    header_params.each do |custom_header, custom_header_value|
        req[custom_header] = custom_header_value
    end

    response = http.request(req)
    
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
  
  def processGet()
    resource = "/reporting/v3/reports?startTime=2018-10-01T00:00:00.0Z&endTime=2018-10-30T23:59:59.0Z&timeQueryType=executedTime&reportMimeType=application/xml"
    method = "get"
    statusCode = -1
    url = URI.encode("https://" + @@request_host + resource)
    
    header_params = {}
    header_params['Accept'] = 'application/hal+json;charset=utf-8'
    header_params['Content-Type'] = 'application/json;charset=utf-8'
    
    auth_names = []
    gmtDateTime = DateTime.now.httpdate
    
    token = getHttpSignature(resource, method, gmtDateTime)
    
    header_params['v-c-merchant-id'] = @@merchant_id
    header_params['Accept-Encoding'] = '*'
    header_params['Date'] = gmtDateTime
    header_params['Host'] = @@request_host
    header_params['User-Agent'] = "Mozilla/5.0"
    header_params['Signature'] = token
    
    headers = @@default_headers.merge(header_params || {})
    
    puts "\n -- RequestURL -- \n"
    puts "\tURL : " + url + "\n"
    puts "\n -- HTTP Headers -- \n"
    puts "\tContent-Type : application/json;charset=utf-8" + "\n"
    puts "\tv-c-merchant-id : " + @@merchant_id + "\n"
    puts "\tDate : " + gmtDateTime + "\n"
    puts "\tHost : " + @@request_host + "\n"
	puts "\tSignature : " + token + "\n"
    
    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    
    header_params.each do |custom_header, custom_header_value|
        req[custom_header] = custom_header_value
    end

    response = http.request(req)

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
  
  def main
    # HTTP POST REQUEST
    puts "\n\nSample 1: POST call - CyberSource Payments API - HTTP POST Payment request"
    @statusCode = processPost()
    
    if @statusCode == 0
        puts "STATUS : SUCCESS (HTTP Status = #@statusCode)"
    else
        puts "STATUS : ERROR (HTTP Status = #@statusCode)"
    end
        
    # HTTP GET REQUEST
    puts "\n\nSample 2: GET call - CyberSource Reporting API - HTTP GET Reporting request"
    @statusCode = processGet()
    
    if @statusCode == 0
        puts "STATUS : SUCCESS (HTTP Status = #@statusCode)"
    else
        puts "STATUS : ERROR (HTTP Status = #@statusCode)"
    end
    
  end
  
  if __FILE__ == $0
    StandAloneHttpSignature.new.main
  end
end