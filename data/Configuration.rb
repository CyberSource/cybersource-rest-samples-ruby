public
class MerchantConfiguration
  def merchantConfigProp()
    # Common Paramaters
    merchantId='testrest'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='http_signature'
    jsonFilePath='resource/request.json'
    logSize=10485760
    enableLog=true
    logDirectory='../log'
    logFilename='cybs'
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
    
    configurationDictionary={}
    configurationDictionary['merchantID']=merchantId
    configurationDictionary['runEnvironment']=runEnvironment
    configurationDictionary['timeout']=timeout
    configurationDictionary['authenticationType']=authenticationType
    configurationDictionary['logDirectory']=logDirectory
    configurationDictionary['jsonFilePath']=jsonFilePath
    configurationDictionary['logSize']=logSize
    configurationDictionary['enableLog']=enableLog
    # configurationDictionary['proxyPort']=proxyPort
    # configurationDictionary['proxyAddress']=proxyAddress
    configurationDictionary['merchantsecretKey']=merchantSecretKey
    configurationDictionary['merchantKeyId']=merchantKeyId
    configurationDictionary['keysDirectory']=keysDirectory
    configurationDictionary['keyAlias']=keyAlias
    configurationDictionary['keyPass']=keyPass
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID
    configurationDictionary['keyFilename'] = keyFilename
    configurationDictionary['logFilename'] = logFilename
    return configurationDictionary
  end

  def alternativeMerchantConfigProp()
    # Common Paramaters
    merchantId='testrest_cpctv'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='http_signature'
    jsonFilePath='resource/request.json'
    logSize=10485760
    enableLog=true
    logDirectory='../log'
    logFilename='cybs'
    # proxyAddress='userproxy.com'
    # proxyPort=443
    # HTTP Parameters
    merchantKeyId='e547c3d3-16e4-444c-9313-2a08784b906a'
    merchantSecretKey='JXm4dqKYIxWofM1TIbtYY9HuYo7Cg1HPHxn29f6waRo='
    # JWT Parameters
    keysDirectory='resource'
    keyAlias='testrest_cpctv'
    keyPass='testrest_cpctv'
    keyFilename='testrest_cpctv'

    # MetaKey Params
    useMetaKey = false
    portfolioID = ''
    
    configurationDictionary={}
    configurationDictionary['merchantID']=merchantId
    configurationDictionary['runEnvironment']=runEnvironment
    configurationDictionary['timeout']=timeout
    configurationDictionary['authenticationType']=authenticationType
    configurationDictionary['logDirectory']=logDirectory
    configurationDictionary['jsonFilePath']=jsonFilePath
    configurationDictionary['logSize']=logSize
    configurationDictionary['enableLog']=enableLog
    # configurationDictionary['proxyPort']=proxyPort
    # configurationDictionary['proxyAddress']=proxyAddress
    configurationDictionary['merchantsecretKey']=merchantSecretKey
    configurationDictionary['merchantKeyId']=merchantKeyId
    configurationDictionary['keysDirectory']=keysDirectory
    configurationDictionary['keyAlias']=keyAlias
    configurationDictionary['keyPass']=keyPass
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID
    configurationDictionary['keyFilename'] = keyFilename
    configurationDictionary['logFilename'] = logFilename
    return configurationDictionary
  end
end