require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_netfunding_information_for_account_or_merchant
    def run()
        start_time = "2019-08-01T00:00:00Z"
        end_time = "2019-09-01T23:59:59Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::NetFundingsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_net_funding_details(start_time, end_time, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_netfunding_information_for_account_or_merchant.new.run()
    end
end
