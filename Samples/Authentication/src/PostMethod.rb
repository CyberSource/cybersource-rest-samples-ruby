require 'cybersource_rest_client'
require_relative '../../../lib/SampleApiClient/controller/APIController.rb'
require_relative '.././data/RequestData.rb'

public
# This is sample code for AuthenticationSDK - POST method
# AuthenticationSDK is called via APISDK
class SamplecodeForPost
  # REQUEST TARGET, REQUEST JSON PATH
    # [Editable]
  @@request_target = '/pts/v2/payments'
  @@requestJsonPath='./resource/request.json'

    # Request Type. [Non-Editable]
  @@request_type = 'POST'

  def write_log_audit(status)
    filename = ($0.split("/")).last.split(".")[0]
    puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  def main
    cybsproperty_obj = PropertiesUtil.new.getCybsProp('resource/cybs.yml')
    merchantconfig_obj = Merchantconfig.new(cybsproperty_obj)

    logObj = Log.new merchantconfig_obj.log_config, 'PostMethod'
    # Set Request Type into the merchant config object.
    merchantconfig_obj.requestType = @@request_type
    # Set Request Target into the merchant config object.
    merchantconfig_obj.requestTarget = @@request_target
    # Construct the URL.
    url = Constants::HTTPS_URI_PREFIX + merchantconfig_obj.requestHost + merchantconfig_obj.requestTarget
    # Set URL into the merchant config object.
    merchantconfig_obj.requestUrl = url
    # SetrequestJsonDataURL into the merchant config object.
    merchantconfig_obj.requestJsonData = RequestData.new.jsonFileData(@@requestJsonPath)
    # Calling APISDK, Apisdk.Controller
    response_code, response_body, vc_correlationid = APIController.new.payment_post(merchantconfig_obj)
    # Display response message and Headers in console.
    puts 'v-c-correlation-id:' + vc_correlationid
    puts 'Response Code:' + response_code
    puts 'Response Body:' + response_body
    write_log_audit(response_code)
  rescue StandardError => err
    puts err.message
    puts err.backtrace
    puts 'Check log for more details.'
    write_log_audit(400)
  end
  SamplecodeForPost.new.main
end
