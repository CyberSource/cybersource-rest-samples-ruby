require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class delete_subscription_of_report_name_by_organization
    def run()
        report_name = "2019test"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_subscription(report_name)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        delete_subscription_of_report_name_by_organization.new.run()
    end
end
