require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Amex_registration_customer_token_batch
    def run()
        request_obj = CyberSource::Body.new
        request_obj.type = "amexRegistration"
        included = CyberSource::Accountupdaterv1batchesIncluded.new

        tokens = []
        tokens1 = CyberSource::Accountupdaterv1batchesIncludedTokens.new
        tokens1.id = "C06977C0EDC0E985E053AF598E0A3326"
        tokens << tokens1

        tokens2 = CyberSource::Accountupdaterv1batchesIncludedTokens.new
        tokens2.id = "C069A534044F6140E053AF598E0AD492"
        tokens << tokens2

        included.tokens = tokens
        request_obj.included = included

        request_obj.merchant_reference = "TC50171_3"
        request_obj.notification_email = "test@cybs.com"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::BatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.post_batch(request_obj)

        puts status_code, headers, data

        write_log_audit(status_code)
        return data, status_code, headers
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Amex_registration_customer_token_batch.new.run()
    end
end
