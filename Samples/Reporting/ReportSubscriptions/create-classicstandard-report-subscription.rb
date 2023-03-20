require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_classicstandard_report_subscription
    def run()
        request_obj = CyberSource::PredefinedSubscriptionRequestBean.new
        request_obj.report_definition_name = "TransactionRequestClass"
        request_obj.subscription_type = "CLASSIC"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_standard_or_classic_subscription(request_obj, opts)

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
        Create_classicstandard_report_subscription.new.run()
    end
end
