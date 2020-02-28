require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class CreateClassicStandardReportSubscription
    def run()
        request_obj = CyberSource::PredefinedSubscriptionRequestBean.new
        request_obj.report_definition_name = "TransactionRequestClass"
        request_obj.subscription_type = "CLASSIC"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_standard_or_classic_subscription(request_obj, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        CreateClassicStandardReportSubscription.new.run()
    end
end
