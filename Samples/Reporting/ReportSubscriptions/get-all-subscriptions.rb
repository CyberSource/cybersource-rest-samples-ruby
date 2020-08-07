require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_all_subscriptions
    def run()

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_all_subscriptions(opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_all_subscriptions.new.run()
    end
end
