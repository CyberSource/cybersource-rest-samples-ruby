require 'cybersource_rest_client'
require_relative '../Subscriptions/create-subscription.rb'
require_relative '../../../data/Configuration.rb'

public
class Get_subscription
    def run()
        id = (JSON.parse(Create_subscription.new.run()[0]))['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_subscription(id)

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
        Get_subscription.new.run()
    end
end