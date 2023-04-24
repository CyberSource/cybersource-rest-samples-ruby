require 'net/http'
require 'cybersource_rest_client'
require_relative '../../../lib/SampleApiClient/Masking/Masking.rb'
require_relative '.././data/RequestData.rb'
#This is sample code for AuthenticationSDK - POST method
public 
class PutGenerateHeaders
  # REQUEST TARGET, REQUEST JSON PATH
    # [Editable]
  @@request_target = '/reporting/v2/reportSubscriptions/TRRReport?organizationId = testrest'
  @@requestJsonPath = '.././resource/TRRReports.json'

  # Request Type. [Non-Editable]
  @@request_type = 'PUT'

  def write_log_audit(status)
      filename = ($0.split("/")).last.split(".")[0]
      puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  public 
  def main()
    begin
      # creating PropetiesUtil object
      cybsPropertyobj = PropertiesUtil.new.getCybsProp('resource/cybs.yml')

      # creating MerchantConfig Object
      merchantConfigObj = Merchantconfig.new cybsPropertyobj

      # creating Logger Object
      logObj = Log.new merchantConfigObj.log_config, 'PutGenerateHeaders'

      #setting requestType,requestTarget,requestUrl
      merchantConfigObj.requestType = @@request_type
      requestUrl =  Constants::HTTPS_URI_PREFIX + merchantConfigObj.requestHost + @@request_target
      gmtDateTime = DateTime.now.httpdate
      authenticationType = merchantConfigObj.authenticationType

      logObj.logger.info("Using Request Target: " + Constants::REQUEST_TARGET)
      logObj.logger.info("Authentication Type -> " + merchantConfigObj.authenticationType)
      logObj.logger.info("Url >" + requestUrl)
      puts "URL    : " +requestUrl

      logObj.logger.info(Constants::CONTENT_TYPE + " : " + Constants::MEDIA_TYPE_JSON)
      puts Constants::CONTENT_TYPE + " : " + Constants::MEDIA_TYPE_JSON

      # checking the Authenticationtype is HTTP_Signature/JWT
      if (authenticationType.upcase ==  Constants::AUTH_TYPE_HTTP) then
        #Http Signature
        logObj.logger.info(Constants::USER_AGENT + "   : " + Constants::USER_AGENT_VALUE)
        puts Constants::USER_AGENT + "   : " + Constants::USER_AGENT_VALUE

        logObj.logger.info("Merchant ID   : " + merchantConfigObj.merchantId)
        puts "Merchant ID   : " + merchantConfigObj.merchantId

        logObj.logger.info("Date  : " + gmtDateTime)
        puts "Date  : " + gmtDateTime

        merchantConfigObj.requestJsonData = RequestData.new.jsonFileData(requestJsonPath)
        maskedRequestBody = Masking.new.maskPayload(merchantConfigObj.requestJsonData)
        logObj.logger.info("Request Body: " + JSON.generate(maskedRequestBody))

        digest = DigestGeneration.new.generateDigest(merchantConfigObj.requestJsonData)
        digest = Constants::SHA256 + digest
        logObj.logger.info("Digest : " + digest)
        puts "Digest  : " + digest 

        tempSig = Authorization.new.getToken(merchantConfigObj,gmtDateTime)
        logObj.logger.info("Host  : " + merchantConfigObj.requestHost)
        puts "Host  : " + merchantConfigObj.requestHost

        logObj.logger.info("Signature Header  : " + tempSig)
        puts "Signature Header  : " + tempSig
      else
        #JWT Token
        tempSig = Authorization.new.getToken(merchantConfigObj,gmtDateTime)
        puts "Authorization,Bearer  : " + tempSig
        logObj.logger.info("Authorization,Bearer  : " + tempSig)
      end
      logObj.logger.info("END> =======================================")
      write_log_audit(200)

    rescue StandardError => err
      puts err.message
      puts err.backtrace
      puts "Check log for more details"
      write_log_audit(400)
    end
  end
  PutGenerateHeaders.new.main()
end