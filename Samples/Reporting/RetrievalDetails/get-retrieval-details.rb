require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_retrieval_details
    def run()
        # QUERY PARAMETERS
        organization_id = "testrest"
        start_time = "2024-08-01T00:00:00Z"
        end_time = "2024-09-01T23:59:59Z"
        opts = {}

        opts[:"organization_id"] = organization_id

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::RetrievalDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_retrieval_details(start_time, end_time, opts)

        puts status_code, headers, data

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
        Get_retrieval_details.new.run()
    end
end