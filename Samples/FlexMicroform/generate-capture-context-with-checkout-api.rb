require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_capture_context_with_checkout_api
    def run()
        request_obj = CyberSource::GenerateCaptureContextRequest.new

        target_origins =  []
        target_origins << "https://www.test.com"
        request_obj.target_origins = target_origins
        request_obj.client_version = "v2.0"

        allowed_card_networks =  []
        allowed_card_networks << "VISA"
        allowed_card_networks << "MASTERCARD"
        allowed_card_networks << "AMEX"
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