public
class Configuration
  def merchantConfigProp()
    merchantId='testrest'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='JWT' #'HTTP_Signature'
    jsonFilePath='./resource/request.json'
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

    enableLog=true
    loggingLevel = 'DEBUG'
    logDirectory='./log'
    logFilename='Cybs'
    maxLogSize=5000
    maxLogFiles=5
    enableMasking=true

    logConfiguration={}
    logConfiguration['enableLog']=enableLog
    logConfiguration['loggingLevel']=loggingLevel
    logConfiguration['logDirectory']=logDirectory
    logConfiguration['logFilename']=logFilename
    logConfiguration['maxLogSize']=maxLogSize
    logConfiguration['maxLogFiles']=maxLogFiles
    logConfiguration['enableMasking']=enableMasking

    configurationDictionary={}
    configurationDictionary['merchantID']=merchantId
    configurationDictionary['runEnvironment']=runEnvironment
    configurationDictionary['timeout']=timeout
    configurationDictionary['authenticationType']=authenticationType
    configurationDictionary['jsonFilePath']=jsonFilePath
    # configurationDictionary['proxyPort']=proxyPort
    configurationDictionary['merchantsecretKey']=merchantSecretKey
    configurationDictionary['merchantKeyId']=merchantKeyId
    configurationDictionary['keysDirectory']=keysDirectory
    configurationDictionary['keyAlias']=keyAlias
    configurationDictionary['keyPass']=keyPass
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID
    configurationDictionary['keyFilename'] = keyFilename
    configurationDictionary['logConfiguration']=logConfiguration
    return configurationDictionary
  end
end
