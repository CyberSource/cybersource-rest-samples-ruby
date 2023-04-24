require 'net/http'
require 'date'
require 'cybersource_rest_client'

# This is sample code for AuthenticationSDK - GET method 
public 
class GetGenerateHeaders
  # UNIQUE GET ID
    # [Editable]
    @@id = '5265502011846829204101'
    # REQUEST TARGET
    # [Editable]
    @@request_target = '/pts/v2/payments/'
    # Request Type. [Non-Editable]
  @@request_type = 'GET'

  def write_log_audit(status)
      filename = ($0.split("/")).last.split(".")[0]
      puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  public 
  def main()
    begin
      #creating propetiesutil Object
      cybsPropertyobj = PropertiesUtil.new.getCybsProp('resource/cybs.yml')

      # creating MerchantConfig Object
      merchantConfigObj = Merchantconfig.new cybsPropertyobj

      # creating Logger Object
      logObj = Log.new merchantConfigObj.log_config, 'GetGenerateHeaders'

      #setting requestType,requestTarget,requestUrl
      merchantConfigObj.requestType = @@request_type
      # Give the url path to where the data needs to be authenticated.
      requestTarget = @@request_target + @@id
      requestUrl =  Constants::HTTPS_URI_PREFIX + merchantConfigObj.requestHost + requestTarget
      gmtDateTime = DateTime.now.httpdate
      authenticationType = merchantConfigObj.authenticationType

      logObj.logger.info("\n")
      logObj.logger.info("Using Request Target: " + requestTarget)
      logObj.logger.info("Authentication Type -> " + merchantConfigObj.authenticationType)
      logObj.logger.info("Url >" + requestUrl)
      puts "URL    : " + requestUrl

      logObj.logger.info(Constants::CONTENT_TYPE + " : " + Constants::MEDIA_TYPE_JSON)
      puts Constants::CONTENT_TYPE + " : " + Constants::MEDIA_TYPE_JSON

      # checking the Authenticationtype is HTTP_Signature/JWT
      if (authenticationType.upcase == Constants::AUTH_TYPE_HTTP) then
        #Http Signature
        logObj.logger.info(Constants::USER_AGENT + "   : " + Constants::USER_AGENT_VALUE)
        puts Constants::USER_AGENT + "   : " + Constants::USER_AGENT_VALUE

        logObj.logger.info("Merchant ID   : " + merchantConfigObj.merchantId)
        puts "Merchant ID   : " + merchantConfigObj.merchantId

        logObj.logger.info("Date  : " + gmtDateTime)
        puts "Date  : " + gmtDateTime

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
  # Reading getId from command line argument
  GetGenerateHeaders.new.main()
end