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
    
    # Set Request MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = true # Enables request MLE globally for all APIs that have optional MLE support //same as older deprecated variable "useMLEGlobally" //APIs that has MLE Request mandatory is default has MLE support in SDK without any configuration but support with JWT auth type.
    configurationDictionary['requestMleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US". //same as older deprecated variable "mleKeyAlias"
    
    # Set Response MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableResponseMleGlobally'] = false # Enables/Disable response MLE globally for all APIs that support MLE responses
    configurationDictionary['responseMlePrivateKeyFilePath'] = '' # Path to the Response MLE private key file. Supported formats: .p12, .pfx, .pem, .key, .p8. Recommendation use encrypted private Key (password protection) for MLE response.
    configurationDictionary['responseMlePrivateKeyFilePassword'] = '' # Password for the private key file (required for .p12/.pfx files or encrypted private keys).
    configurationDictionary['responseMleKID'] = '' # This parameter is optional when responseMlePrivateKeyFilePath points to a CyberSource-generated P12 file. If not provided, the SDK will automatically fetch the Key ID from the P12 file. If provided, the SDK will use the user-provided value instead of the auto-fetched value.
    # Required when using PEM format files (.pem, .key, .p8) or when providing responseMlePrivateKey object directly.

    configurationDictionary
  end

  def self.merchantConfigPropWithMLEMAPAndGlobalFlag()
    configurationDictionary = MerchantConfiguration.commonConfig
    
    # Set Request MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    mapToControlMLE = {
      'create_payment' => 'false', # only create_payment function will have MLE=false i.e. (/pts/v2/payments POST API) out of all MLE supported APIs
      'capture_payment' => 'true' # capture_payment function will have MLE=true i.e.  (/pts/v2/payments/{id}/captures POST API), if it not in list of MLE supportedAPIs else it will already have MLE=true by global MLE parameter.
    }
    
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = true # Enables request MLE globally for all APIs that have optional MLE support //same as older deprecated variable "useMLEGlobally"
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE # disable or enable the MLE for APIs which is in the list of mleMAP
    configurationDictionary['requestMleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US". //same as older deprecated variable "mleKeyAlias"
    
    # Set Response MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableResponseMleGlobally'] = false # Enables/Disable response MLE globally for all APIs that support MLE responses
    configurationDictionary['responseMlePrivateKeyFilePath'] = '' # Path to the Response MLE private key file. Supported formats: .p12, .pfx, .pem, .key, .p8. Recommendation use encrypted private Key (password protection) for MLE response.
    configurationDictionary['responseMlePrivateKeyFilePassword'] = '' # Password for the private key file (required for .p12/.pfx files or encrypted private keys).
    configurationDictionary['responseMleKID'] = '' # This parameter is optional when responseMlePrivateKeyFilePath points to a CyberSource-generated P12 file. If not provided, the SDK will automatically fetch the Key ID from the P12 file. If provided, the SDK will use the user-provided value instead of the auto-fetched value.
    # Required when using PEM format files (.pem, .key, .p8) or when providing responseMlePrivateKey object directly.
    
    configurationDictionary
  end

  def self.merchantConfigPropWithMLEMAPAndGlobalFlagDisabled()
    configurationDictionary = MerchantConfiguration.commonConfig
    
    # Set Request MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    mapToControlMLE = {
      'create_payment' => 'true', # create_payment function will have MLE=true i.e. (/pts/v2/payments POST API)
      'capture_payment' => 'true' # capture_payment function will also have MLE=true i.e. (/pts/v2/payments/{id}/captures POST API)
    }
    
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = false # Disabled request MLE globally for all APIs that have optional MLE support //same as older deprecated variable "useMLEGlobally"
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE # disable or enable the MLE for APIs which is in the list of mleMAP
    configurationDictionary['requestMleKeyAlias']='CyberSource_SJC_US' # this is optional parameter, not required to set the parameter if custom value is not required for MLE key alias. Default value is "CyberSource_SJC_US". //same as older deprecated variable "mleKeyAlias"
    
    # Set Response MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableResponseMleGlobally'] = false # Enables/Disable response MLE globally for all APIs that support MLE responses
    configurationDictionary['responseMlePrivateKeyFilePath'] = '' # Path to the Response MLE private key file. Supported formats: .p12, .pfx, .pem, .key, .p8. Recommendation use encrypted private Key (password protection) for MLE response.
    configurationDictionary['responseMlePrivateKeyFilePassword'] = '' # Password for the private key file (required for .p12/.pfx files or encrypted private keys).
    configurationDictionary['responseMleKID'] = '' # This parameter is optional when responseMlePrivateKeyFilePath points to a CyberSource-generated P12 file. If not provided, the SDK will automatically fetch the Key ID from the P12 file. If provided, the SDK will use the user-provided value instead of the auto-fetched value.
    # Required when using PEM format files (.pem, .key, .p8) or when providing responseMlePrivateKey object directly.
    
    configurationDictionary
  end

  def self.getMerchantDetailsWithRequestAndResponseMLE1()
    configurationDictionary = MerchantConfiguration.commonConfig
    
    # Override merchant-specific settings for MLE testing
    configurationDictionary['merchantID'] = 'agentic_mid_091225001'
    configurationDictionary['keyAlias'] = 'agentic_mid_091225001'
    configurationDictionary['keyPass'] = 'Changeit@123'
    configurationDictionary['keyFilename'] = 'agentic_mid_091225001'
    
    # Set Request MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = true # Enables request MLE globally for all APIs that have optional MLE support //same as older deprecated variable "useMLEGlobally" //APIs that has MLE Request mandatory is default has MLE support in SDK without any configuration but support with JWT auth type.
    
    # Set Response MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableResponseMleGlobally'] = true # Enables response MLE globally for all APIs that support MLE responses
    configurationDictionary['responseMlePrivateKeyFilePath'] = 'resource/agentic_mid_091225001_new_generated_mle.p12' # Path to the Response MLE private key file. Supported formats: .p12, .pfx, .pem, .key, .p8. Recommendation use encrypted private Key (password protection) for MLE response.
    configurationDictionary['responseMlePrivateKeyFilePassword'] = 'Changeit@123' # Password for the private key file (required for .p12/.pfx files or encrypted private keys).
    configurationDictionary['responseMleKID'] = '1764104507829324018353' # Optional since p12 is Cybs Generated.
    # This parameter is optional when responseMlePrivateKeyFilePath points to a CyberSource-generated P12 file. If not provided, the SDK will automatically fetch the Key ID from the P12 file. If provided, the SDK will use the user-provided value instead of the auto-fetched value.
    # Required when using PEM format files (.pem, .key, .p8) or when providing responseMlePrivateKey object directly.

    configurationDictionary
  end

  def self.getMerchantDetailsWithRequestAndResponseMLE2()
    configurationDictionary = MerchantConfiguration.commonConfig
    
    # Override merchant-specific settings for MLE testing
    configurationDictionary['merchantID'] = 'agentic_mid_091225001'
    configurationDictionary['keyAlias'] = 'agentic_mid_091225001'
    configurationDictionary['keyPass'] = 'Changeit@123'
    configurationDictionary['keyFilename'] = 'agentic_mid_091225001'
    
    # Set Request MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = false # Disable request MLE globally for all APIs that have optional MLE support //same as older deprecated variable "useMLEGlobally" //APIs that has MLE Request mandatory is default has MLE support in SDK without any configuration but support with JWT auth type.
    
    # Set Response MLE Settings in Merchant Configuration [Refer MLE.md on cybersource-rest-client-ruby github repo]
    configurationDictionary['enableResponseMleGlobally'] = false # Disable response MLE globally for all APIs that support MLE responses
    
    # Set Request & Response MLE Settings in Merchant Configuration through MAP for API control level [Refer MLE.md on cybersource-rest-client-ruby github repo]
    mapToControlMLE = {
      'create_payment' => 'true::false', # only create_payment function will have Request MLE=true and Response MLE = false i.e. (/pts/v2/payments POST API)
      'enroll_card' => 'true::true' # only enroll_card function will have Request MLE=true & Response MLE =true i.e. (/acp/v1/tokens POST API)
    }
    
    configurationDictionary['mapToControlMLEonAPI'] = mapToControlMLE # disable or enable the MLE for APIs which is in the list of mleMAP
    
    # since one of the API has Response MLE true, so below fields are required for Response MLE
    configurationDictionary['responseMlePrivateKeyFilePath'] = 'resource/agentic_mid_091225001_mle.p12' # Path to the Response MLE private key file. Supported formats: .p12, .pfx, .pem, .key, .p8. Recommendation use encrypted private Key (password protection) for MLE response.
    configurationDictionary['responseMlePrivateKeyFilePassword'] = 'Changeit@123' # Password for the private key file (required for .p12/.pfx files or encrypted private keys).
    configurationDictionary['responseMleKID'] = '1757970970891045729358' # Optional since p12 is Cybs Generated.
    # This parameter is optional when responseMlePrivateKeyFilePath points to a CyberSource-generated P12 file. If not provided, the SDK will automatically fetch the Key ID from the P12 file. If provided, the SDK will use the user-provided value instead of the auto-fetched value.
    # Required when using PEM format files (.pem, .key, .p8) or when providing responseMlePrivateKey object directly.

    configurationDictionary
  end
end
