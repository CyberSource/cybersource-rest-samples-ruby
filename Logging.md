[![Generic badge](https://img.shields.io/badge/LOGGING-NEW-GREEN.svg)](https://shields.io/)

# Logging in CyberSource REST Client SDK (Ruby)

Since v0.0.38, a new logging framework has been introduced in the SDK. This new logging framework makes use of Ruby's logger package, and standardizes the logging so that it can be integrated with the logging in the client application.

## Ruby's logger package Configuration

In order to leverage the new logging framework, the following configuration settings may be added to the merchant configuration as part of **`LogConfiguration`**:

* enableLog
* loggingLevel
* logDirectory
* logFilename
* maxLogSize
* maxLogFiles
* enableMasking

In our [sample Configuration.py](https://github.com/CyberSource/cybersource-rest-samples-ruby/blob/master/data/Configuration.rb) file, the following lines have been added to support this new framework:

```ruby
    enableLog=true
    loggingLevel='DEBUG'
    logDirectory='log'
    logFilename='cybs'
    maxLogSize=10485760
    maxLogFiles=5
    enableMasking=true
    ...
    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking
    configurationDictionary['logConfiguration'] = log_config
```

### Important Notes

The variable `enableMasking` needs to be set to `true` if sensitive data in the request/response should be hidden/masked.

Sensitive data fields are listed below:

  * Card Security Code
  * Card Number
  * Any field with `number` in the name
  * Card Expiration Month
  * Card Expiration Year
  * Account
  * Routing Number
  * Email
  * First Name & Last Name
  * Phone Number
  * Type
  * Token
  * Signature
