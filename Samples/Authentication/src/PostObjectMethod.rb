require 'cybersource_rest_client'
require_relative '../../../lib/SampleApiClient/controller/APIController.rb'
require_relative '.././data/RequestData.rb'

#This is sample code for AuthenticationSDK - POST method
# AuthenticationSDK is called via APISDK
public
class SamplecodeForPostObject
  # REQUEST TARGET, REQUEST JSON PATH
	# [Editable]
  @@request_target = '/pts/v2/payments'
  
  # Request Type. [Non-Editable]
  @@request_type = 'POST'

  public
  def main()
    begin
      require_relative '.././data/Configuration.rb'
      cybsPropertyobj = Configuration.new.merchantConfigProp
      merchantConfigObj = Merchantconfig.new cybsPropertyobj

      logObj = Log.new merchantConfigObj.log_config, 'PostObjectMethod'
      # setting requestTarget to merchant
      merchantConfigObj.requestTarget = @@request_target
      merchantConfigObj.requestJsonData = RequestData.new.samplePaymentsData()
      # Give the url path to where the data needs to be authenticated.
      url = Constants::HTTPS_URI_PREFIX + merchantConfigObj.requestHost + merchantConfigObj.requestTarget
      merchantConfigObj.requestType = @@request_type
      merchantConfigObj.requestUrl = url
      # Calling APISDK, ApiController
      responsecode,responseBody,v_c_correlationId =  APIController.new.payment_post(merchantConfigObj)
      puts "v-c-correlation-id:"  + v_c_correlationId
      puts "Response Code:" + responsecode
      puts "Response Body:" + responseBody
    rescue => err
      puts err.message
      puts err.backtrace
    end
  end
  SamplecodeForPostObject.new.main
end
