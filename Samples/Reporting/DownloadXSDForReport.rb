require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class DownloadXSDForReport
    def run(report_definition_name_version)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DownloadXSDApi.new(api_client, config)

        data, status_code, headers = api_instance.get_x_s_d_v2(report_definition_name_version)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <reportDefinitionNameVersion>:"
        reportDefinitionNameVersion = gets.chomp

        DownloadXSDForReport.new.run(reportDefinitionNameVersion)
    end
end
