require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_capture_context_with_checkout_api
    def run()
        request_obj = CyberSource::GenerateCaptureContextRequest.new

        request_obj.client_version = "v2"

        target_origins =  []
        target_origins << "https://www.test.com"

        allowed_payment_types =  []
        allowed_payment_types << "CHECK"
        request_obj.target_origins = target_origins
        request_obj.allowed_payment_types= allowed_payment_types

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::MicroformIntegrationApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_capture_context(request_obj)

        puts status_code, headers, data
        unless data.nil?
            merchant_config = api_instance.api_client.merchantconfig
            parsed_jwt_response = CyberSource::Utilities::CaptureContext::CaptureContextParser.parse_capture_context_response(data, merchant_config)
            puts "\n=== Parsed and Verified JWT Response ==="
            puts parsed_jwt_response
            puts "=" * 31
        end

        return data
    rescue StandardError => err
        puts err.message
        puts err.backtrace
    end
    if __FILE__ == $0
        Generate_capture_context_with_checkout_api.new.run()
    end
end
