require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_conversion_detail_transactions
    def run()
        start_time = "2019-03-21T00:00:00Z"
        end_time = "2019-03-21T23:00:00Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ConversionDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_conversion_detail(start_time, end_time, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_conversion_detail_transactions.new.run()
    end
end
