require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_report_definition
    def run()
        report_definition_name = "AcquirerExceptionDetailClass"
        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportDefinitionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_resource_info_by_report_definition(report_definition_name, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_report_definition.new.run()
    end
end
