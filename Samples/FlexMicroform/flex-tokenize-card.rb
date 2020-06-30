require 'cybersource_rest_client'
require_relative '../KeyGeneration/generate-key.rb'
require_relative '../../../data/Configuration.rb'

public
class Flex_tokenize_card
    def run()
        key_generation_response = JSON.parse(Generate_key.new.run)
        public_key = key_generation_response['der']['publicKey']
	
        request_obj = CyberSource::TokenizeRequest.new
        request_obj.key_id = key_generation_response['keyId']
        card_info = CyberSource::Flexv1tokensCardInfo.new
        card_info.card_number = "4111111111111111"
        card_info.card_expiration_month = "12"
        card_info.card_expiration_year = "2031"
        card_info.card_type = "001"
        request_obj.card_info = card_info

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TokenizationApi.new(api_client, config)

        data, status_code, headers = api_instance.tokenize(request_obj)

        token_verifier = CyberSource::TokenVerification.new
        is_token_verified = token_verifier.verifyToken(public_key, data)
	    print "Token Verification : ", is_token_verified, "\n"

        puts status_code, headers, data
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Flex_tokenize_card.new.run()
    end
end
