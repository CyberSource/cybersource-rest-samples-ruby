require 'cybersource_rest_client'
require_relative '../../../lib/SampleApiClient/controller/APIController.rb'

public
# This is sample code for AuthenticationSDK - DELETE method
# AuthenticationSDK is called via APISDK
class SamplecodeForDelete
  # REQUEST TARGET
	  # [Editable]
    @@request_target = '/reporting/v2/reportSubscriptions/TRRReport?organizationId=testrest'
    
    # Request Type. [Non-Editable]
    @@request_type = 'DELETE'
    
  def main
    # creating PropertiesUtil object
    cybsproperty_obj = PropertiesUtil.new.getCybsProp('resource/cybs.yml')

    # creating MerchantConfig Object
    merchantconfig_obj = Merchantconfig.new(cybsproperty_obj)

    logObj = Log.new merchantconfig_obj.log_config, 'DeleteMethod'
    # setting requestTarget,requestUrl,requestType to merchantConfig Object
    merchantconfig_obj.requestTarget = @@request_target
    # Give the url path to where the data needs to be authenticated.
    url = Constants::HTTPS_URI_PREFIX + merchantconfig_obj.requestHost + merchantconfig_obj.requestTarget
    merchantconfig_obj.requestUrl = url
    merchantconfig_obj.requestType = @@request_type

    # Calling APISDK, ApiController
    response_code, response_body, vc_correlationid = APIController.new.payment_delete(merchantconfig_obj)
    puts 'v-c-correlation-id:' + vc_correlationid
    puts 'Response Code:' + response_code
    puts 'Response Body:' + response_body
  rescue StandardError => err
    puts 'Check log for more details.'
  end
  SamplecodeForDelete.new.main
end
