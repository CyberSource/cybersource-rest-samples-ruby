require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_capture_context_with_checkout_api
    def run()
        request_obj = CyberSource::GenerateCaptureContextRequest.new

        request_obj.client_version = "v2"

        target_origins =  []
        target_origins << "https://www.test.com"
        request_obj.target_origins = target_origins

        allowed_card_networks =  []
        allowed_card_networks << "VISA"
        allowed_card_networks << "MASTERCARD"
        allowed_card_networks << "AMEX"
        allowed_card_networks << "CARNET"
        allowed_card_networks << "CARTESBANCAIRES"
        allowed_card_networks << "CUP"
        allowed_card_networks << "DINERSCLUB"
        allowed_card_networks << "DISCOVER"
        allowed_card_networks << "EFTPOS"
        allowed_card_networks << "ELO"
        allowed_card_networks << "JCB"
        allowed_card_networks << "JCREW"
        allowed_card_networks << "MADA"
        allowed_card_networks << "MAESTRO"
        allowed_card_networks << "MEEZA"
        request_obj.allowed_card_networks = allowed_card_networks

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::MicroformIntegrationApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_capture_context(request_obj)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Generate_capture_context_with_checkout_api.new.run()
    end
end