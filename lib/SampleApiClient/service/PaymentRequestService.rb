require 'cybersource_rest_client'
require_relative '../connection/HttpConnection.rb'
require_relative '../connection/JwtConnection.rb'

public
# Here the call is made to respective connection class (HTTPConnection or JWTConnection)
# depending on the Authentication type.
class PaymentService
  def paymentService(merchantconfig_obj)
    log_obj = Log.new merchantconfig_obj.log_config, 'PaymentRequestService'
    authentication_type = merchantconfig_obj.authenticationType
    if merchantconfig_obj.requestType.to_s.empty?
      raise Constants::ERROR_PREFIX + Constants::REQUEST_TYPE_EMPTY
    end
    if authentication_type.upcase == Constants::AUTH_TYPE_HTTP
      # HTTP Connection
      response_code, response_body, vc_correlationid = HttpConnection.new.getHTTPConnection(merchantconfig_obj)
    elsif authentication_type.upcase == Constants::AUTH_TYPE_JWT
      # JWT Connection
      response_code, response_body, vc_correlationid = JwtConnection.new.getJWTConnection(merchantconfig_obj) 
    elsif authentication_type.upcase != Constants::AUTH_TYPE_HTTP || authentication_type.upcase != Constants::AUTH_TYPE_JWT
      raise Constants::ERROR_PREFIX + Constants::AUTH_ERROR
    end
    return response_code, response_body, vc_correlationid
  rescue StandardError => err
    log_obj.logger.error(err.message)
    log_obj.logger.error(err.backtrace)
    exit!
  end
end
