#
# The BankAccountValidationConfiguration.rb provides the necessary settings for 
# Bank Account Validation (BAV) using the CyberSource REST API. 
# This configuration uses JWT authentication, which is required for Request MLE. 
# The BAV API mandates Request MLE, and JWT is the only supported authentication type for this feature.
# By Default SDK sends encrypted requests for the APIs having mandatory Request MLE flag.
# For more MLE features and configurations, please refer to CyberSource documentation at https://github.com/CyberSource/cybersource-rest-client-ruby/blob/master/MLE.md
#

class MerchantConfiguration
  def self.commonConfig()
    merchantId='testcasmerchpd01001'
    runEnvironment='apitest.cybersource.com'
    timeout=1000 #In Milliseconds
    authenticationType='JWT'
    enableLog=true
    loggingLevel='DEBUG'
    logDirectory='log'
    logFilename='cybs'
    maxLogSize=10485760
    maxLogFiles=5
    enableMasking = true
    keyFilename='testcasmerchpd01001'
    configurationDictionary={}
    configurationDictionary['merchantID'] = merchantId
    configurationDictionary['runEnvironment'] = runEnvironment
    configurationDictionary['timeout'] = timeout
    configurationDictionary['authenticationType'] = authenticationType

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
    keyAlias='testcasmerchpd01001'
    keyPass='Authnet101!'
    keyFilename='testcasmerchpd01001'
    configurationDictionary['keysDirectory'] = keysDirectory
    configurationDictionary['keyAlias'] = keyAlias
    configurationDictionary['keyPass'] = keyPass
    configurationDictionary['keyFilename'] = keyFilename

    configurationDictionary['logConfiguration'] = log_config
    configurationDictionary
  end
  def self.bankAccountValidationConfiguration()
    configurationDictionary = MerchantConfiguration.commonConfig

    configurationDictionary
  end
end
