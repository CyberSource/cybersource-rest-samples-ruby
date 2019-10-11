require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class TokenizeCard
    def run()
        request_obj = CyberSource::TokenizeRequest.new
        request_obj.key_id = "08z9hCmn4pRpdNhPJBEYR3Mc2DGLWq5j"
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

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        TokenizeCard.new.run()
    end
end
