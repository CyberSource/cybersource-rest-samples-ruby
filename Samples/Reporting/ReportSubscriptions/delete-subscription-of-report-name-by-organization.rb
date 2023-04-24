require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Delete_subscription_of_report_name_by_organization
    def run()
        report_name = "testrest_v2"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_subscription(report_name)

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
        Delete_subscription_of_report_name_by_organization.new.run()
    end
end
