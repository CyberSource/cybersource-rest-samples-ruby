require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class create_report_subscription
    def run()
        request_obj = CyberSource::CreateReportSubscriptionRequest.new
        request_obj.report_definition_name = "TransactionRequestClass"

        report_fields =  []
        report_fields << "Request.RequestID"
        report_fields << "Request.TransactionDate"
        report_fields << "Request.MerchantID"
        request_obj.report_fields = report_fields
        request_obj.report_mime_type = "application/xml"
        request_obj.report_frequency = "WEEKLY"
        request_obj.report_name = "testrest_subcription_v1"
        request_obj.timezone = "GMT"
        request_obj.start_time = "0900"
        request_obj.start_day = 1

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_subscription(request_obj, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        create_report_subscription.new.run()
    end
end
