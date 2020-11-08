# Ruby Sample Code for the CyberSource SDK
[![Travis CI Status](https://travis-ci.org/CyberSource/cybersource-rest-samples-ruby.svg?branch=master)](https://travis-ci.org/CyberSource/cybersource-rest-samples-ruby)

This repository contains working code samples which demonstrate Ruby integration with the CyberSource REST APIs through the [CyberSource Ruby SDK](https://github.com/CyberSource/cybersource-rest-client-ruby).


## Using the Sample Code

The samples are all completely independent and self-contained. You can analyze them to get an understanding of how a particular method works, or you can use the snippets as a starting point for your own project.  The samples are organized into categories and common usage examples, similar to the [CyberSource API Reference](http://developer.cybersource.com/api/reference).

You can run each sample directly from the command line.

## Requirements
* Ruby 2.5.0 or higher
* [CyberSource Account](https://developer.cybersource.com/api/developer-guides/dita-gettingstarted/registration.html)
* [CyberSource API Keys](https://developer.cybersource.com/api/developer-guides/dita-gettingstarted/registration/createCertSharedKey.html)

## Running the Samples From the Command Line
* Clone this repository:
```
    $ git clone https://github.com/CyberSource/cybersource-rest-samples-ruby
```
* Install the cybersource-rest-client-ruby (from RubyGems.org)
```
    $ gem install cybersource_rest_client
```
* Run the individual samples by name. For example: 
```
    $ Ruby [DirectoryPath]/[CodeSampleName]
```
e.g.
```
    $ ruby Samples/Payments/CoreServices/ProcessPayment.rb
```

## Setting your own API credentials for an API request

Configure the following information in the data/Configuration.rb file:
  
  * Http Signature 

```ruby
    merchantId='your_merchant_id'
    authenticationType='http_signature'   
    # HTTP Parameters
    merchantKeyId='your_key_serial_number'
    merchantSecretKey='your_key_shared_secret'
```
  * Jwt

```ruby
    merchantId='your_merchant_id'
    # JWT Parameters
    keysDirectory='resource'
    keyAlias='your_merchant_id'
    keyPass='your_merchant_id'
    keyFilename='your_merchant_id'
```

## Switching between the sandbox environment and the production environment
CyberSource maintains a complete sandbox environment for testing and development purposes. This sandbox environment is an exact 
duplicate of our production environment with the transaction authorization and settlement process simulated. By default, this sample code is 
configured to communicate with the sandbox environment. To switch to the production environment, set the appropriate environment 
constant in data/Configuration.rb file.  For example:

```Ruby
# For TESTING use
runEnvironment='cybersource.environment.sandbox'
# For PRODUCTION use
# runEnvironment='cybersource.environment.production'
```

## API Reference

The [API Reference Guide](http://developer.cybersource.com/api/reference) provides examples of what information is needed for a particular request and how that information would be formatted. Using those examples, you can easily determine what methods would be necessary to include that information in a request using this SDK.

