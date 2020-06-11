require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_report_based_on_report_id
    def run()
        report_id = "79642c43-2368-0cd5-e053-a2588e0a7b3c"
        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_report_by_report_id(report_id, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_report_based_on_report_id.new.run()
    end
end
