# Ruby Sample Code for the CyberSource SDK

[![Build Status](https://app.travis-ci.com/CyberSource/cybersource-rest-samples-ruby.svg?branch=master)](https://app.travis-ci.com/CyberSource/cybersource-rest-samples-ruby)

This repository contains working code samples which demonstrate Ruby integration with the CyberSource REST APIs through the [CyberSource Ruby SDK](https://github.com/CyberSource/cybersource-rest-client-ruby).


## Using the Sample Code

The samples are all completely independent and self-contained. You can analyze them to get an understanding of how a particular method works, or you can use the snippets as a starting point for your own project.  The samples are organized into categories and common usage examples, similar to the [CyberSource API Reference](http://developer.cybersource.com/api/reference).

You can run each sample directly from the command line.

## Requirements

* Ruby 3.1.0 or higher
* [CyberSource Account](https://developer.cybersource.com/api/developer-guides/dita-gettingstarted/registration.html)
* [CyberSource API Keys](https://developer.cybersource.com/api/developer-guides/dita-gettingstarted/registration/createCertSharedKey.html)

## Running the Samples From the Command Line

* Clone this repository:

```bash
    git clone https://github.com/CyberSource/cybersource-rest-samples-ruby
```

* Install the cybersource-rest-client-ruby (from RubyGems.org)

```bash
    gem install cybersource_rest_client
```
* Run the individual samples by name. For example: 

```bash
    ruby [DirectoryPath]/[CodeSampleName]
```
e.g.

```bash
    ruby Samples/Payments/Payments/simple-authorizationinternet.rb
```

## Setting Your API Credentials

To set your API credentials for an API request, configure the following information in `data/Configuration.rb` file:

* Http Signature (**Deprecated** — migrate to JWT with Shared Secret below)

```ruby
    merchantId                  = 'your_merchant_id'
    authenticationType          = 'http_signature'
    # HTTP Parameters
    merchantKeyId               = 'your_key_serial_number'
    merchantSecretKey           = 'your_key_shared_secret'
    runEnvironment              = 'apitest.cybersource.com'
```

* Jwt (with P12 certificate)

```ruby
    authenticationType          = 'jwt'
    merchantId                  = 'your_merchant_id'
    keyAlias                    = 'your_merchant_id'
    keyPass                     = 'your_merchant_id'
    keyFilename                 = 'your_merchant_id'
    keysDirectory               = 'resource'
    useMetaKey                  = false
    runEnvironment              = 'apitest.cybersource.com'
```

* Jwt with Shared Secret (**Recommended migration path from Http Signature**)

  Uses the **same** `merchantKeyId` and `merchantsecretKey` credentials as Http Signature, but authenticates via JWT. This enables MLE (Message Level Encryption) support for both request and response payloads, which Http Signature does not support.

  For detailed migration guide, configuration, and sample code, see the [JWT Shared Secret Auth samples](Samples/JwtSharedSecretAuth/README.md).

```ruby
    authenticationType          = 'jwt'
    jwtKeyType                  = 'SHARED_SECRET'
    merchantId                  = 'your_merchant_id'
    merchantKeyId               = 'your_key_serial_number'
    merchantSecretKey           = 'your_shared_secret'
    runEnvironment              = 'apitest.cybersource.com'
```

* MetaKey Http (**Deprecated** — migrate to MetaKey JWT Shared Secret below)

```ruby
    authenticationType          = 'http_signature'
    merchantId                  = 'your_transacting_merchant_id'
    merchantKeyId               = 'your_metakey_portfolio_KeyId'
    merchantSecretKey           = 'your_metakey_portfolio_shared_secret_key'
    portfolioID                 = 'your_portfolio_id'
    useMetaKey                  = true
```

* MetaKey JWT (P12)

```ruby
    authenticationType          = 'jwt'
    merchantId                  = 'your_transacting_merchant_id'
    keyAlias                    = 'your_portfolio_id'
    keyPass                     = 'your_metakey_portfolio_p12File_password'
    keyFilename                 = 'your_metakey_portfolio_p12FileName'
    portfolioID                 = 'your_portfolio_id'
    keysDirectory               = 'resource'
    useMetaKey                  = true
```

* MetaKey JWT with Shared Secret (**Recommended migration from MetaKey Http**)

  Uses the same MetaKey credentials as MetaKey Http but authenticates via JWT, enabling MLE support.

```ruby
    authenticationType          = 'jwt'
    jwtKeyType                  = 'SHARED_SECRET'
    merchantId                  = 'your_transacting_merchant_id'
    merchantKeyId               = 'your_metakey_portfolio_KeyId'
    merchantSecretKey           = 'your_metakey_portfolio_shared_secret_key'
    portfolioID                 = 'your_portfolio_id'
    useMetaKey                  = true
```

* Response MLE with MetaKey

  When Response MLE is enabled (`enableResponseMleGlobally: true`) and MetaKey is in use (`useMetaKey: true`), the Response MLE configuration must use the **portfolio's** response MLE key — not the transacting merchant's. Specifically:

  - `responseMlePrivateKeyFilePath` (or `responseMlePrivateKey` object) must point to the **portfolio's** response MLE private key.
  - `responseMleKID` — the KID value associated with the **portfolio's** response MLE certificate.
    - **Optional** when `responseMlePrivateKeyFilePath` points to a CyberSource-generated P12 file (SDK auto-fetches from P12).
    - **Required** when using PEM format files (`.pem`, `.key`, `.p8`) or when providing `responseMlePrivateKey` object directly.

```ruby
    enableResponseMleGlobally           = true
    responseMlePrivateKeyFilePath       = 'resource/portfolio_response_mle_private_key.p12'
    responseMlePrivateKeyFilePassword   = 'portfolio_private_key_password'
    # responseMleKID is optional when using a CyberSource-generated P12 file (auto-fetched from P12)
    # Required when using PEM files or responseMlePrivateKey object
    # responseMleKID                    = 'your_portfolio_response_mle_kid'
```

  > **Important:** The response MLE private key (and KID, if applicable) must belong to the portfolio (parent account), since in MetaKey mode the portfolio is the transaction submitter and the response is encrypted using the portfolio's MLE certificate.

## Switching between the sandbox environment and the production environment

CyberSource maintains a complete sandbox environment for testing and development purposes. This sandbox environment is an exact duplicate of our production environment with the transaction authorization and settlement process simulated. By default, this sample code is configured to communicate with the sandbox environment. To switch to the production environment, set the appropriate environment constant in data/Configuration.rb file.  For example:

```ruby
   # For TESTING use
     runEnvironment='apitest.cybersource.com'
   # For PRODUCTION use
   # runEnvironment='api.cybersource.com'
```

## Run Environments

The run environments that were supported in CyberSource Ruby SDK have been deprecated.
Moving forward, the SDKs will only support the direct hostname as the run environment.

For the old run environments previously used, they should be replaced by the following hostnames:

| Old Run Environment                             | New Hostname Value           |
| ----------------------------------------------- | ---------------------------- |
| `cybersource.environment.sandbox`               | `apitest.cybersource.com`    |
| `cybersource.environment.production`            | `api.cybersource.com`        |
| `cybersource.in.environment.sandbox`            | `apitest.cybersource.com`    |
| `cybesource.in.environment.production`          | `api.in.cybersource.com`     |

For example, replace the following code in the Configuration file:

```ruby
   # For TESTING use
     runEnvironment='cybersource.environment.sandbox'
   # For PRODUCTION use
   # runEnvironment='cybersource.environment.production'
```

with the following code:

```ruby
   # For TESTING use
     runEnvironment='apitest.cybersource.com'
   # For PRODUCTION use
   # runEnvironment='api.cybersource.com'
```

## API Reference

The [API Reference Guide](http://developer.cybersource.com/api/reference) provides examples of what information is needed for a particular request and how that information would be formatted. Using those examples, you can easily determine what methods would be necessary to include that information in a request using this SDK.

## Logging

[![Generic badge](https://img.shields.io/badge/LOGGING-NEW-GREEN.svg)](https://shields.io/)

Since v0.0.38, a new logging framework has been introduced in the SDK. This new logging framework makes use of Ruby's logger package, and standardizes the logging so that it can be integrated with the logging in the client application.

More information about this new logging framework can be found in this file : [Logging.md](Logging.md)

## Disclaimer

Cybersource may allow Customer to access, use, and/or test a Cybersource product or service that may still be in development or has not been market-tested (“Beta Product”) solely for the purpose of evaluating the functionality or marketability of the Beta Product (a “Beta Evaluation”). Notwithstanding any language to the contrary, the following terms shall apply with respect to Customer’s participation in any Beta Evaluation (and the Beta Product(s)) accessed thereunder): The Parties will enter into a separate form agreement detailing the scope of the Beta Evaluation, requirements, pricing, the length of the beta evaluation period (“Beta Product Form”). Beta Products are not, and may not become, Transaction Services and have not yet been publicly released and are offered for the sole purpose of internal testing and non-commercial evaluation. Customer’s use of the Beta Product shall be solely for the purpose of conducting the Beta Evaluation. Customer accepts all risks arising out of the access and use of the Beta Products. Cybersource may, in its sole discretion, at any time, terminate or discontinue the Beta Evaluation. Customer acknowledges and agrees that any Beta Product may still be in development and that Beta Product is provided “AS IS” and may not perform at the level of a commercially available service, may not operate as expected and may be modified prior to release. CYBERSOURCE SHALL NOT BE RESPONSIBLE OR LIABLE UNDER ANY CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE RELATING TO A BETA PRODUCT OR THE BETA EVALUATION (A) FOR LOSS OR INACCURACY OF DATA OR COST OF PROCUREMENT OF SUBSTITUTE GOODS, SERVICES OR TECHNOLOGY, (B) ANY CLAIM, LOSSES, DAMAGES, OR CAUSE OF ACTION ARISING IN CONNECTION WITH THE BETA PRODUCT; OR (C) FOR ANY INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES INCLUDING, BUT NOT LIMITED TO, LOSS OF REVENUES AND LOSS OF PROFITS.
