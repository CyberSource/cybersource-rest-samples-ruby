public
class Configuration
  def merchantConfigProp()
    merchantId='testrest'
    runEnvironment='cybersource.environment.sandbox'
    timeout=1000 #In Milliseconds
    authenticationType='JWT' #'HTTP_Signature'
    logDirectory='./log'
    jsonFilePath='./resource/request.json'
    logSize=5000
    enableLog=true
    #proxyAddress='userproxy.visa.com'
    #proxyPort=443
    # HTTP Parameters
    merchantSecretKey='yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE='
    merchantKeyId='08c94330-f618-42a3-b09d-e1e43be5efda'
    # JWT Parameters
    keysDirectory='./resource'
    keyAlias='testrest'
    keyPass='testrest'
    keyFilename='testrest'

    # MetaKey Params
    useMetaKey = false
    portfolioID = ''
    
    logFilename='Cybs'
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
