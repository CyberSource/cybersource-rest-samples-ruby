require 'base64'
require 'openssl'
require 'jwt'
require 'json'
require 'date'
require 'net/http'
require 'uri'
require 'active_support'

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

  @@default_headers = {}

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
        jwtBody = "{\n      \"digest\":\"" + digest + "\", \"digestAlgorithm\":\"SHA-256\", \"iat\":\"" + gmtdatetime + "\"}"
    elsif http_method == "get"
        jwtBody = "{\n \"iat\":\"" + gmtdatetime + "\"\n} \n\n"
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
    url = URI.encode("https://" + @@request_host + resource)
    
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
    header_params['Date'] = gmtDateTime
    header_params['Host'] = @@request_host
    
    payload = @@payload
    digest = Digest::SHA256.base64digest(payload)
    digest_payload = 'SHA-256=' + digest
    header_params['Digest'] = digest_payload
    
    headers = @@default_headers.merge(header_params || {})
    
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
    StandAloneJWT.new.main
  end
end