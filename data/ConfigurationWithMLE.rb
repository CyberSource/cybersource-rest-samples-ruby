class MerchantConfiguration
  def self.commonConfig()
    merchantId='testrest'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='JWT'
    jsonFilePath='resource/request.json'
    enableLog=true
    loggingLevel='DEBUG'
    logDirectory='log'
    logFilename='cybs'
    maxLogSize=10485760
    maxLogFiles=5
    enableMasking = true
    keyFilename='testrest'
    configurationDictionary={}
    configurationDictionary['merchantID'] = merchantId
    configurationDictionary['runEnvironment'] = runEnvironment
    configurationDictionary['timeout'] = timeout
    configurationDictionary['authenticationType'] = authenticationType
    configurationDictionary['jsonFilePath'] = jsonFilePath

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking
    configurationDictionary['keyFilename'] = keyFilename

    keysDirectory='resource'
    keyAlias='testrest'
    keyPass='testrest'
    keyFilename='testrest'
    configurationDictionary['keysDirectory'] = keysDirectory
    configurationDictionary['keyAlias'] = keyAlias
    configurationDictionary['keyPass'] = keyPass
    configurationDictionary['keyFilename'] = keyFilename

    configurationDictionary['logConfiguration'] = log_config
    configurationDictionary
  end
  def self.merchantConfigPropWithoutMLEMAP()
    configurationDictionary = MerchantConfiguration.commonConfig
    configurationDictionary['useMLEGlobally'] = true
    configurationDictionary['mleKeyAlias']='CyberSource_SJC_US'

    configurationDictionary
  end

  def merchantConfigPropWithMLEMAPAndGlobalFlag()
    configurationDictionary = MerchantConfiguration.commonConfig
    configurationDictionary['useMLEGlobally'] = true
    mapToControlMLE = {
      'createPayment' => false,
      'capturePayment' => true
    }
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE
    configurationDictionary
  end

  def self.merchantConfigPropWithMLEMAPAndGlobalFlagDisabled()
    configurationDictionary = MerchantConfiguration.commonConfig
    configurationDictionary['useMLEGlobally'] = false
    mapToControlMLE = {
      'createPayment' => true,
      'capturePayment' => true
    }
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE
    configurationDictionary
  end
end