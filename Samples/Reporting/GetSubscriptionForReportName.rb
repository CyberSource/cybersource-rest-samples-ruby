require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetSubscriptionForReportName
    def run(report_name)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_subscription(report_name)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <reportName>:"
        reportName = gets.chomp

        GetSubscriptionForReportName.new.run(reportName)
    end
end
