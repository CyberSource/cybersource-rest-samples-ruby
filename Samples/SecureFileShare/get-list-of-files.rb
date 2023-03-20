require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Get_list_of_files
    def run()
        start_date = "2020-07-20"
        end_date = "2020-07-30"

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"name"] = nil

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SecureFileShareApi.new(api_client, config)

        data, status_code, headers = api_instance.get_file_detail(start_date, end_date, opts)

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
        Get_list_of_files.new.run()
    end
end
