require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class generate_key
    def run()
        request_obj = CyberSource::GeneratePublicKeyRequest.new
        request_obj.encryption_type = "None"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::KeyGenerationApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_public_key(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        generate_key.new.run()
    end
end
