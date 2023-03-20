require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_key
    def run()
        request_obj = CyberSource::GeneratePublicKeyRequest.new
        request_obj.encryption_type = "RsaOaep"
        request_obj.target_origin = "https://www.test.com"
        format = "JWT"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::KeyGenerationApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_public_key(format, request_obj)

        puts data, status_code, headers

        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Generate_key.new.run()
    end
end
