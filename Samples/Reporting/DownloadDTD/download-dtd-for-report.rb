require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class download-dtd-for-report
    def run(report_definition_name_version)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DownloadDTDApi.new(api_client, config)

        data, status_code, headers = api_instance.get_d_t_d_v2(report_definition_name_version)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <reportDefinitionNameVersion>:"
        reportDefinitionNameVersion = gets.chomp

        download-dtd-for-report.new.run(reportDefinitionNameVersion)
    end
end
