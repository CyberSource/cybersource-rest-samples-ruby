require 'cybersource_rest_client'
require_relative '../../../lib/SampleApiClient/controller/APIController.rb'

public
# This is sample code for AuthenticationSDK - GET method
# AuthenticationSDK is called via APISDK
class SamplecodeForGet
    # UNIQUE GET ID
    # [Editable]
    @@id = '5535107993816925603005'
    # REQUEST TARGET
    # [Editable]
    @@request_target = '/pts/v2/payments/'
    # Request Type. [Non-Editable]
    @@request_type = 'GET'
    
  def main
    cybsproperty_obj = PropertiesUtil.new.getCybsProp('resource/cybs.yml')
    merchantconfig_obj = Merchantconfig.new(cybsproperty_obj)

    logObj = Log.new merchantconfig_obj.log_config, 'GetMethod'
    # Set Request Type into the merchant config object.
    merchantconfig_obj.requestType = @@request_type
    # Set Request Target into the merchant config object.
    merchantconfig_obj.requestTarget = @@request_target + @@id
    # Construct the URL.
    url = Constants::HTTPS_URI_PREFIX + merchantconfig_obj.requestHost + merchantconfig_obj.requestTarget
    # Set URL into the merchant config object.
    merchantconfig_obj.requestUrl = url
    # Calling APISDK, Apisdk.controller.
    response_code, response_body, vc_correlationid = APIController.new.payment_get(merchantconfig_obj)
    # Display response message and Headers in console.
    puts 'v-c-correlation-id:' + vc_correlationid
    puts 'Response Code:' + response_code
    puts 'Response Body:' + response_body
  rescue StandardError => err
    puts 'Check log for more details.'
  end
  SamplecodeForGet.new.main
end
