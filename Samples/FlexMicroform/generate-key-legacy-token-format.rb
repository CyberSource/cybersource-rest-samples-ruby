require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_key_legacy_token_format
    def run()
        request_obj = CyberSource::GeneratePublicKeyRequest.new
        request_obj.encryption_type = "None"
        request_obj.target_origin = "https://www.test.com"
        format = "legacy"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::KeyGenerationApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_public_key(format, request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Generate_key_legacy_token_format.new.run()
    end
end
