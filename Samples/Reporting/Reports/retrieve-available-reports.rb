require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Retrieve_available_reports
    def run()
        start_time = "2021-04-01T00:00:00Z"
        end_time = "2021-04-03T23:59:59Z"
        time_query_type = "executedTime"

        opts = {}
        opts[:"report_mime_type"] = "application/xml"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.search_reports(start_time, end_time, time_query_type, opts)

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
        Retrieve_available_reports.new.run()
    end
end
