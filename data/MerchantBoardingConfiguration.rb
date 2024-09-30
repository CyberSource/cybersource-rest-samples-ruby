require 'cybersource_rest_client'

public
class MerchantBoardingConfiguration
  def merchantBoardingConfigProp()
    # Common Paramaters
    authenticationType='jwt'
    merchantId='<insert merchantId here for testing the boarding samples>'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    jsonFilePath='resource/request.json'
    enableLog=true
    loggingLevel='DEBUG'
    logDirectory='log'
    logFilename='cybs'
    maxLogSize=10485760
    maxLogFiles=5
    enableMasking=true
    # proxyAddress='userproxy.com'
    # proxyPort=443
    # HTTP Parameters
    merchantKeyId=''
    merchantSecretKey=''
    # JWT Parameters
    keysDirectory='resource'
    keyAlias='<insert keyAlias (merchantId)  here for testing the boarding samples>'
    keyPass='insert p12 file password here for testing the boarding samples'
    keyFilename='<insert p12 file name without .p12 extension here for testing the boarding samples>'

    # MetaKey Params
    useMetaKey = false
    portfolioID = ''
    
    configurationDictionary={}
    configurationDictionary['merchantID'] = merchantId
    configurationDictionary['runEnvironment'] = runEnvironment
    configurationDictionary['timeout'] = timeout
    configurationDictionary['authenticationType'] = authenticationType
    configurationDictionary['jsonFilePath'] = jsonFilePath
    # configurationDictionary['proxyPort'] = proxyPort
    # configurationDictionary['proxyAddress'] = proxyAddress
    configurationDictionary['merchantsecretKey'] = merchantSecretKey
    configurationDictionary['merchantKeyId'] = merchantKeyId
    configurationDictionary['keysDirectory'] = keysDirectory
    configurationDictionary['keyAlias'] = keyAlias
    configurationDictionary['keyPass'] = keyPass
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID
    configurationDictionary['keyFilename'] = keyFilename

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking

    configurationDictionary['logConfiguration'] = log_config

    return configurationDictionary
  end
end