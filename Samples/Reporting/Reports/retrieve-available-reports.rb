require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class retrieve_available_reports
    def run()
        start_time = "2018-10-01T00:00:00Z"
        end_time = "2018-10-30T23:59:59Z"
        time_query_type = "executedTime"

        opts = {}
        opts[:"report_mime_type"] = "application/xml"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.search_reports(start_time, end_time, time_query_type, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        retrieve_available_reports.new.run()
    end
end
