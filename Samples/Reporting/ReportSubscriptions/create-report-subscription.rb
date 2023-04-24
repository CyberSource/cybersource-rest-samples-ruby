require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_report_subscription
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
        Create_report_subscription.new.run()
    end
end
