require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Find_products_you_can_subscribe_to
    def run(organization_id)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreateNewWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.find_products_to_subscribe(organization_id, opts)

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
        Find_products_you_can_subscribe_to.new.run(organization_id)
    end
end