require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class create_adhoc_report
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
        request_obj.report_start_time = Time.new("2018-09-01T12:30:00.000+05:30")
        request_obj.report_end_time = Time.new("2018-09-02T12:30:00.000+05:30")
        report_preferences = CyberSource::Reportingv3reportsReportPreferences.new
        report_preferences.signed_amounts = TRUE
        report_preferences.field_name_convention = "SOAPI"
        request_obj.report_preferences = report_preferences


        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_report(request_obj, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        create_adhoc_report.new.run()
    end
end
