require 'cybersource_rest_client'

public
class ConfigurationForBatchUpload
  def merchantConfigProp()
    # Common Paramaters
    merchantId='qaebc2'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='jwt'
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
    merchantKeyId='08c94330-f618-42a3-b09d-e1e43be5efda'
    merchantSecretKey='yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE='
    # JWT Parameters
    keysDirectory='resource'
    keyAlias='qaebc2'
    keyPass='?Test1234'
    keyFilename='qaebc2'

    # MetaKey Params
    useMetaKey = false
    portfolioID = ''

    # Add the property if required to override the cybs default developerId in all request body
    defaultDeveloperId = ""
    
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
    configurationDictionary['defaultDeveloperId'] = defaultDeveloperId

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking

    configurationDictionary['logConfiguration'] = log_config

    # PEM Key file path for decoding JWE Response Enter the folder path where the .pem file is located.
    # It is optional property, require adding only during JWE decryption.
    configurationDictionary['pemFileDirectory'] = 'resource/NetworkTokenCert.pem'

    return configurationDictionary
  end
end