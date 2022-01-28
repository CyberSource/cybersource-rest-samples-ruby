require 'json'
require 'net/http'
require 'openssl'
require 'cybersource_rest_client'
require_relative './IConnection.rb'
require_relative '../Masking/Masking.rb'
# Here all the data ( header + digest + Signature ) are set inside the HTTP connection and the call is made to API 
# server and response message and code is obtained.
public
class JwtConnection
  @@gmtDateTime = DateTime.now
  @@gmtDateTime = @@gmtDateTime.httpdate
  # This is function for calling GET/POST based on the requestType
  public
  def getJWTConnection(merchantconfig_obj)
    log_obj = Log.new merchantconfig_obj.log_config, 'JwtConnection'
    log_obj.logger.info('Request Type > ' + merchantconfig_obj.requestType)
    log_obj.logger.info('Authentication Type > '+ merchantconfig_obj.authenticationType)
    uri_string = merchantconfig_obj.requestUrl
    log_obj.logger.info('Url > ' + uri_string)
    uri = URI.parse(uri_string)
    req = open_connection(merchantconfig_obj.requestType,uri)
    # Appending headers for Get Connection
    req.initialize_http_header({Constants::CONTENT_TYPE => Constants::MEDIA_TYPE_JSON})
    # Calling Authentication SDK for generating Signature
    token = Authorization.new.getToken(merchantconfig_obj,@@gmtDateTime)
    token  = "Bearer " + token
    req.add_field("Authorization",token)
    if(merchantconfig_obj.requestType == Constants::POST_REQUEST_TYPE || merchantconfig_obj.requestType == Constants::PUT_REQUEST_TYPE)
      payload = merchantconfig_obj.requestJsonData
      req.body = payload
      masked_request_body = masking_data(payload)
      log_obj.logger.info('Request Body:' + JSON.generate(masked_request_body))
    end
    req.each_header do |key, value|
      log_obj.logger.info("#{key} : #{value}")
    end
    http_proxy = set_Proxy(merchantconfig_obj.proxyAddress,merchantconfig_obj.proxyPort)
    # Establish the connection with server and receives the response message and code
    http_proxy.start(uri.host, uri.port,use_ssl: true, verify_mode:
        OpenSSL::SSL::VERIFY_NONE) do |http| #new
        http.read_timeout = 5000
        response = http.request (req)
        if merchantconfig_obj.requestType == Constants::DELETE_REQUEST_TYPE
            response_body = response.body
        else
            response_body = masking_data(response.body)
        end
        v_c_CorrelationID = response.each_header.to_h
        log_obj.logger.info('v-c-correlation-id:' + v_c_CorrelationID['v-c-correlation-id'])
        log_obj.logger.info('Response Code:' + response.code)
        log_obj.logger.info('Response Body:' + response_body)
        log_obj.logger.info('END> = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = == = ')
        return response.code,response_body,v_c_CorrelationID['v-c-correlation-id']
    end
  rescue StandardError => err
    log_obj.logger.error(err.message)
    log_obj.logger.error(err.backtrace)
    puts 'Check log for more details.'
    exit!
  end
  public
  def open_connection(requestType,uri)
    if(requestType.upcase == Constants::GET_REQUEST_TYPE) then
      req = Net::HTTP::Get.new(uri)
    elsif(requestType.upcase == Constants::POST_REQUEST_TYPE) then
      req = Net::HTTP::Post.new(uri)
    elsif(requestType.upcase == Constants::PUT_REQUEST_TYPE) then
      req = Net::HTTP::Put.new(uri)
    elsif(requestType.upcase == Constants::DELETE_REQUEST_TYPE) then
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
  public 
  def masking_data(payload)
    maskedData = Masking.new.maskPayload(payload)
    return maskedData
  end
  implements ConnectionInterface
end
