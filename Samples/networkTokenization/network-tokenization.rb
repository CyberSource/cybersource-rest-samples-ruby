# frozen_string_literal: true


require 'cybersource_rest_client'
require_relative './payment-credentials-from-network-token'

public
class NetworkTokenization
  def run()

    config = MerchantConfiguration.new.merchantConfigProp
    require 'AuthenticationSDK/core/MerchantConfig'
    merchant_configuration = Merchantconfig.new(config)

    # Step-I
    encoded_payment_credentials_response = Payment_credentials_from_network_token.new.run

    #Step-II
    decoded_response = CyberSource::JWEUtility.decryptJWEResponse(encoded_payment_credentials_response, merchant_configuration)

    puts 'Decoded Response'
    puts decoded_response
  end

  if __FILE__ == $0
    NetworkTokenization.new.run
  end
end
