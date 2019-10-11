require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetReportDefinition
    def run(report_definition_name)

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportDefinitionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_resource_info_by_report_definition(report_definition_name, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <reportDefinitionName>:"
        reportDefinitionName = gets.chomp
        puts "\nInput missing query parameter <organizationId>:"
        organizationId = gets.chomp

        GetReportDefinition.new.run(reportDefinitionName, organizationId)
    end
end
