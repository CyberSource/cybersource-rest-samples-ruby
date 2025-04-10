require 'cybersource_rest_client'

public
class MerchantConfiguration
  def merchantConfigProp()
    # Common Paramaters
    merchantId='testrest'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='http_signature'
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
    keyAlias='testrest'
    keyPass='testrest'
    keyFilename='testrest'

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

  def alternativeMerchantConfigProp()
    # Common Paramaters
    merchantId='testrest_cpctv'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='http_signature'
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
    merchantKeyId='964f2ecc-96f0-4432-a742-db0b44e6a73a'
    merchantSecretKey='zXKpCqMQPmOR/JRldSlkQUtvvIzOewUVqsUP0sBHpxQ='
    # JWT Parameters
    keysDirectory='resource'
    keyAlias='testrest_cpctv'
    keyPass='testrest_cpctv'
    keyFilename='testrest_cpctv'

    # MetaKey Params
    useMetaKey = false
    portfolioID = ''
    
    configurationDictionary={}
    configurationDictionary['merchantID'] = merchantId
    configurationDictionary['runEnvironment'] = runEnvironment
    configurationDictionary['timeout'] = timeout
    configurationDictionary['authenticationType'] = authenticationType
    # configurationDictionary['jsonFilePath'] = jsonFilePath
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

  def batchUploadMerchantConfigProp()
    # Common Parameters
    merchantId = 'qaebc2'
    runEnvironment = 'apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType = 'jwt'
    jsonFilePath = 'resource/request.json'

    # MetaKey Parameters
    useMetaKey = false
    portfolioID = ''

    # JWT Parameters
    keysDirectory = 'resource'
    keyAlias = 'qaebc2'
    keyPass = '?Test1234'
    keyFilename = 'qaebc2'

    # Logging Parameters
    enableLog = true
    logDirectory = 'log'
    loggingLevel='DEBUG'
    logFilename = 'cybs'
    maxLogSize=10485760
    maxLogFiles=5
    enableMasking=true

    # OAuth Parameters
    enableClientCert = false
    clientCertDirectory = 'src/main/resources'
    clientCertFile = ''
    clientCertPassword = ''
    clientId = ''
    clientSecret = ''

    # Developer ID override
    defaultDeveloperId = ''

    configurationDictionary = {}
    configurationDictionary['merchantID'] = merchantId
    configurationDictionary['runEnvironment'] = runEnvironment
    configurationDictionary['authenticationType'] = authenticationType
    configurationDictionary['timeout'] = timeout
    configurationDictionary['jsonFilePath'] = jsonFilePath
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID
    configurationDictionary['keysDirectory'] = keysDirectory
    configurationDictionary['keyAlias'] = keyAlias
    configurationDictionary['keyPass'] = keyPass
    configurationDictionary['keyFilename'] = keyFilename
    configurationDictionary['defaultDeveloperId'] = defaultDeveloperId

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['loggingLevel'] = loggingLevel
    log_config['enableMasking'] = enableMasking

    configurationDictionary['logConfiguration'] = log_config

    return configurationDictionary
  end
end