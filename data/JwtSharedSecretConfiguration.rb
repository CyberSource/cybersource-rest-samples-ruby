require 'cybersource_rest_client'

# Configuration for JWT authentication with Shared Secret (symmetric / HS256).
#
# Why JWT with Shared Secret?
# - HTTP Signature is being deprecated. JWT with Shared Secret provides a
#   seamless migration path — it uses the same merchantKeyId and
#   merchantsecretKey credentials you already have for HTTP Signature.
# - Enables MLE (Message Level Encryption). MLE requires JWT authentication.
#   By switching to JWT with Shared Secret, you can enable MLE without managing
#   a P12 certificate file.
# - Zero credential changes. Your existing Key ID and Shared Secret from the
#   CyberSource Business Center work as-is.
#
# Credentials:
# The merchantKeyId and merchantsecretKey are the same credentials
# used for HTTP Signature authentication. You can obtain them from the CyberSource
# Business Center:
# - Test: https://businesscentertest.cybersource.com/ebc2
# - Production: https://businesscenter.cybersource.com/ebc2

class JwtSharedSecretConfiguration

  # Returns merchant properties configured for JWT authentication with Shared Secret.
  #
  # This is a drop-in replacement for HTTP Signature authentication.
  # The only changes from a typical HTTP Signature configuration are:
  # 1. authenticationType = 'jwt' (instead of 'http_signature')
  # 2. jwtKeyType = 'SHARED_SECRET' (new property)
  #
  # The merchantKeyId and merchantsecretKey remain the same.
  def self.merchantConfigPropWithJwtSharedSecret()
    # Common Parameters
    authenticationType = 'jwt'          # JWT authentication instead of http_signature
    jwtKeyType = 'SHARED_SECRET'        # New property for JWT Shared Secret
    runEnvironment = 'apitest.cybersource.com'
    merchantId = 'testrest'
    timeout = 1000 # In Milliseconds

    # Shared Secret credentials — same as HTTP Signature credentials
    merchantKeyId = '08c94330-f618-42a3-b09d-e1e43be5efda'
    merchantSecretKey = 'yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE='

    # MetaKey Parameters
    useMetaKey = false
    portfolioID = ''

    # Logging Parameters
    enableLog = true
    loggingLevel = 'DEBUG'
    logDirectory = 'log'
    logFilename = 'cybs'
    maxLogSize = 10485760
    maxLogFiles = 5
    enableMasking = true

    configurationDictionary = {}
    # Authentication: JWT with Shared Secret (HS256)
    configurationDictionary['authenticationType'] = authenticationType
    configurationDictionary['jwtKeyType'] = jwtKeyType
    configurationDictionary['runEnvironment'] = runEnvironment

    configurationDictionary['merchantID'] = merchantId
    # Shared Secret credentials — same as HTTP Signature credentials
    configurationDictionary['merchantKeyId'] = merchantKeyId
    configurationDictionary['merchantsecretKey'] = merchantSecretKey
    configurationDictionary['timeout'] = timeout

    # MetaKey Parameters
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking

    configurationDictionary['logConfiguration'] = log_config

    configurationDictionary
  end

  # Returns merchant properties configured for JWT with Shared Secret + MLE enabled.
  #
  # This configuration enables Message Level Encryption (MLE) for request payloads.
  # Response MLE is also supported — set enableResponseMleGlobally to true
  # and provide the response MLE private key settings.
  #
  # When using jwtKeyType=SHARED_SECRET, Request MLE requires the public certificate
  # to be provided via mleForRequestPublicCertPath because there is no P12 file
  # to auto-extract it from.
  #
  # Download the MLE public certificate from the CyberSource Business Center:
  # - Test: https://businesscentertest.cybersource.com/ebc2
  # - Production: https://businesscenter.cybersource.com/ebc2
  def self.merchantConfigPropWithJwtSharedSecretAndMLE()
    # Common Parameters
    authenticationType = 'jwt'          # JWT authentication instead of http_signature
    jwtKeyType = 'SHARED_SECRET'        # New property for JWT Shared Secret
    runEnvironment = 'apitest.cybersource.com'
    merchantId = 'testrest'
    timeout = 1000 # In Milliseconds

    # Shared Secret credentials — same as HTTP Signature credentials
    merchantKeyId = '08c94330-f618-42a3-b09d-e1e43be5efda'
    merchantSecretKey = 'yBJxy6LjM2TmcPGu+GaJrHtkke25fPpUX+UY6/L/1tE='

    # MetaKey Parameters
    useMetaKey = false
    portfolioID = ''

    # Logging Parameters
    enableLog = true
    loggingLevel = 'DEBUG'
    logDirectory = 'log'
    logFilename = 'cybs'
    maxLogSize = 10485760
    maxLogFiles = 5
    enableMasking = true

    # MLE Certificate path for JWT Shared Secret
    # When using SHARED_SECRET, the MLE certificate must be provided separately.
    # Download from CyberSource Business Center:
    #   Test: https://businesscentertest.cybersource.com/ebc2
    #   Prod: https://businesscenter.cybersource.com/ebc2
    mleForRequestPublicCertPath = 'resource/MLE_PublicCert.pem'

    configurationDictionary = {}
    # Authentication: JWT with Shared Secret (HS256)
    configurationDictionary['authenticationType'] = authenticationType
    configurationDictionary['jwtKeyType'] = jwtKeyType
    configurationDictionary['runEnvironment'] = runEnvironment

    configurationDictionary['merchantID'] = merchantId
    # Shared Secret credentials — same as HTTP Signature credentials
    configurationDictionary['merchantKeyId'] = merchantKeyId
    configurationDictionary['merchantsecretKey'] = merchantSecretKey
    configurationDictionary['timeout'] = timeout

    # MetaKey Parameters
    configurationDictionary['useMetaKey'] = useMetaKey
    configurationDictionary['portfolioID'] = portfolioID

    log_config = {}
    log_config['enableLog'] = enableLog
    log_config['loggingLevel'] = loggingLevel
    log_config['logDirectory'] = logDirectory
    log_config['logFilename'] = logFilename
    log_config['maxLogSize'] = maxLogSize
    log_config['maxLogFiles'] = maxLogFiles
    log_config['enableMasking'] = enableMasking

    configurationDictionary['logConfiguration'] = log_config

    # --- Request MLE Configuration ---
    # When using SHARED_SECRET, the MLE certificate must be provided separately.
    # Download from CyberSource Business Center:
    #   Test: https://businesscentertest.cybersource.com/ebc2
    #   Prod: https://businesscenter.cybersource.com/ebc2
    configurationDictionary['enableRequestMLEForOptionalApisGlobally'] = true
    configurationDictionary['mleForRequestPublicCertPath'] = mleForRequestPublicCertPath
    # requestMleKeyAlias: Optional — defaults to CyberSource_SJC_US
    # configurationDictionary['requestMleKeyAlias'] = 'CyberSource_SJC_US'

    # --- Response MLE Configuration ---
    # Set to true to enable response MLE (encrypted responses from CyberSource).
    # Requires a private key for decryption.
    configurationDictionary['enableResponseMleGlobally'] = false
    # Provide EITHER a private key file path OR a PrivateKey object.
    # Supported formats: .p12, .pfx, .pem, .key, .p8
    configurationDictionary['responseMlePrivateKeyFilePath'] = '' # e.g., 'resource/your_mle_private_key.p12'
    configurationDictionary['responseMlePrivateKeyFilePassword'] = '' # Required for .p12/.pfx or encrypted keys
    # responseMleKID: Optional for CyberSource-generated P12 files (auto-extracted).
    # Required for PEM/KEY files or when providing PrivateKey object directly.
    configurationDictionary['responseMleKID'] = ''

    configurationDictionary
  end
end
