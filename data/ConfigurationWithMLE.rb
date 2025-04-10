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
    configurationDictionary['useMLEGlobally'] = true # globally MLE will be enabled for all the MLE supported APIs by Cybs in SDK
    configurationDictionary['mleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US".

    configurationDictionary
  end

  def self.merchantConfigPropWithMLEMAPAndGlobalFlag()
    configurationDictionary = MerchantConfiguration.commonConfig
    configurationDictionary['useMLEGlobally'] = true # globally MLE will be enabled for all the MLE supported APIs by Cybs in SDK
    mapToControlMLE = {
      'create_payment' => false, # only create_payment function will have MLE=false i.e. (/pts/v2/payments POST API) out of all MLE supported APIs
      'capture_payment' => true # capture_payment function will have MLE=true i.e.  (/pts/v2/payments/{id}/captures POST API), if it not in list of MLE supportedAPIs else it will already have MLE=true by global MLE parameter.
    }
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE
    configurationDictionary['mleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US".
    configurationDictionary
  end

  def self.merchantConfigPropWithMLEMAPAndGlobalFlagDisabled()
    configurationDictionary = MerchantConfiguration.commonConfig
    configurationDictionary['useMLEGlobally'] = false # globally MLE will be disabled for all the APIs in SDK
    mapToControlMLE = {
      'create_payment' => true, # create_payment function will have MLE=true i.e. (/pts/v2/payments POST API)
      'capture_payment' => true # capture_payment function will also have MLE=true i.e. (/pts/v2/payments/{id}/captures POST API)
    }
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE
    configurationDictionary['mleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US".
    configurationDictionary
  end
end
