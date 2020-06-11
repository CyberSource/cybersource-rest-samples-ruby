require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Get_list_of_files
    def run()
        start_date = "2020-03-20"
        end_date = "2020-03-30"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SecureFileShareApi.new(api_client, config)

        data, status_code, headers = api_instance.get_file_detail(start_date, end_date, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_list_of_files.new.run()
    end
end
