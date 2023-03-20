require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_netfunding_information_for_account_or_merchant
    def run()
        start_time = "2021-01-01T00:00:00Z"
        end_time = "2021-02-01T23:59:59Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::NetFundingsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_net_funding_details(start_time, end_time, opts)

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
        Get_netfunding_information_for_account_or_merchant.new.run()
    end
end
