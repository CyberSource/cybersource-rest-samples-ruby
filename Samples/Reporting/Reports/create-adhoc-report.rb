require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_adhoc_report
    def run()
        request_obj = CyberSource::CreateAdhocReportRequest.new
        request_obj.report_definition_name = "TransactionRequestClass"

        report_fields =  []
        report_fields << "Request.RequestID"
        report_fields << "Request.TransactionDate"
        report_fields << "Request.MerchantID"
        request_obj.report_fields = report_fields
        request_obj.report_mime_type = "application/xml"
        request_obj.report_name = "testrest_v2"
        request_obj.timezone = "GMT"
        request_obj.report_start_time = "2020-03-01T12:00:00.000Z"
        request_obj.report_end_time = "2020-03-02T12:00:00.000Z"
        report_preferences = CyberSource::Reportingv3reportsReportPreferences.new
        report_preferences.signed_amounts = true
        report_preferences.field_name_convention = "SOAPI"
        request_obj.report_preferences = report_preferences


        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_report(request_obj, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_adhoc_report.new.run()
    end
end
