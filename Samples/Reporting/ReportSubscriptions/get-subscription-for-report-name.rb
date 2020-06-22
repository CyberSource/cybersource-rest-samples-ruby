require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_subscription_for_report_name
    def run()
        opts = {}
        report_name = "testrest_subcription_v1"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_subscription(report_name, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_subscription_for_report_name.new.run()
    end
end
