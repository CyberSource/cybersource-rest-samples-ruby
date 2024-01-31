require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_details_on_single_webhook
    def run(webhook_id)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ManageWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.get_webhook_subscription_by_id(webhook_id, opts = {})

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
        Get_details_on_single_webhook.new.run(webhook_id)
    end
end