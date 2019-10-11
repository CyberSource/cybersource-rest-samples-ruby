require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetReportBasedOnReportId
    def run(report_id)

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_report_by_report_id(report_id, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <reportId>:"
        reportId = gets.chomp
        puts "\nInput missing query parameter <organizationId>:"
        organizationId = gets.chomp

        GetReportBasedOnReportId.new.run(reportId, organizationId)
    end
end
