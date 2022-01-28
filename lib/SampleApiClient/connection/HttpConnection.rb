require 'json'
require 'net/http'
require 'openssl'
require 'date'
require 'cybersource_rest_client'
require_relative './IConnection.rb'
require_relative '../Masking/Masking.rb'
public
# Here all the data ( header + digest + Signature ) are set inside the HTTP connection and the call is made to API
# server and response message and code is obtained.
class HttpConnection
  @@gmtDateTime = DateTime.now
  # date format is 'Mon, 09 Apr 2018 10:18:57 GMT'
  @@gmtDateTime = @@gmtDateTime.httpdate
  public

  # This function generate token for GET method
  # Token = header+ signature
  def getHTTPConnection (merchantconfig_obj)
    log_obj = Log.new merchantconfig_obj.log_config, 'HttpConnection'
    log_obj.logger.info('Request Type > ' + merchantconfig_obj.requestType)
    log_obj.logger.info('Authentication Type > '+ merchantconfig_obj.authenticationType)
    uri_string = merchantconfig_obj.requestUrl
    log_obj.logger.info('Url > ' + uri_string)
    uri = URI.parse(uri_string)
    req = open_connection(merchantconfig_obj.requestType, uri)
    req.initialize_http_header({ Constants::USER_AGENT => Constants::USER_AGENT_VALUE })
    # Appending headers for Get Connection
    req.add_field(Constants::CONTENT_TYPE, Constants::MEDIA_TYPE_JSON)
    req.add_field(Constants::V_C_MERCHANT_ID, merchantconfig_obj.merchantId)
    req.add_field(Constants::DATE, @@gmtDateTime)
    req.add_field(Constants::HOST, merchantconfig_obj.requestHost)
    if merchantconfig_obj.requestType == Constants::POST_REQUEST_TYPE || merchantconfig_obj.requestType ==  Constants::PUT_REQUEST_TYPE
      payload = merchantconfig_obj.requestJsonData
      digest = DigestGeneration.new.generateDigest(payload)
      digest_payload = Constants::SHA256 + digest
      req.add_field('Digest', digest_payload)
      req.body = payload
      masked_request_body = masking_data(payload)
      log_obj.logger.info('Request Body:' + JSON.generate(masked_request_body))
    end
    # Calling Authentication SDK for generating Signature
    signature = Authorization.new.getToken(merchantconfig_obj, @@gmtDateTime)
    req.add_field(Constants::SIGNATURE, signature)
    req.each_header do |key, value|
      log_obj.logger.info("#{key} : #{value}")
    end
    http_proxy = set_Proxy(merchantconfig_obj.proxyAddress,merchantconfig_obj.proxyPort)
    # Establish the connection with server and receives the response message and code
    http_proxy.start(uri.host, uri.port, use_ssl: true, verify_mode:
      OpenSSL::SSL::VERIFY_NONE) do |http|
      http.read_timeout = 1000
      response = http.request req
      if merchantconfig_obj.requestType == Constants::DELETE_REQUEST_TYPE
        response_body = response.body
      else
        response_body = masking_data(response.body)
      end
      vc_correlationid = response.each_header.to_h
      log_obj.logger.info('v-c-correlation-id:' + vc_correlationid['v-c-correlation-id'])
      log_obj.logger.info('Response Code:' + response.code)
      log_obj.logger.info('Response Body:' + response_body)
      log_obj.logger.info('END> ===========================================')
      return response.code, response_body, vc_correlationid['v-c-correlation-id']
    end
  rescue StandardError => err
    if err.message.include? 'No such host is known.'
      log_obj.logger.error(Constants::ERROR_PREFIX + Constants::RUN_ENVIRONMENT)
    else
      log_obj.logger.error(err.message)
      log_obj.logger.error(err.backtrace)
    end
    puts 'Check log for more details.'
    exit!
  end

 public

  def open_connection(request_type, uri)
    if request_type.upcase == Constants::GET_REQUEST_TYPE
      req = Net::HTTP::Get.new(uri)
    elsif request_type.upcase == Constants::POST_REQUEST_TYPE
      req = Net::HTTP::Post.new(uri)
    elsif request_type.upcase == Constants::PUT_REQUEST_TYPE
      req = Net::HTTP::Put.new(uri)
    elsif request_type.upcase == Constants::DELETE_REQUEST_TYPE
      req = Net::HTTP::Delete.new(uri)
    else
      raise StandardError.new(Constants::ERROR_PREFIX + Constants::INVALID_REQUEST_TYPE_METHOD)
    end
    return req
  end
  def set_Proxy(proxyAddress,proxyPort)
    if !proxyAddress.to_s.empty? && !proxyPort.to_s.empty?
      http_proxy = Net::HTTP.Proxy(proxyAddress,proxyPort)
    else
      http_proxy = Net::HTTP
    end
  end
  def masking_data(payload)
    masked_data = Masking.new.maskPayload(payload)
    return masked_data
  end
  implements ConnectionInterface
end
