require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_chargeback_details
    def run()
        # QUERY PARAMETERS
        organization_id = "testrest"
        start_time = "2021-08-01T00:00:00Z"
        end_time = "2021-09-01T23:59:59Z"
        opts = {}

        opts[:"organization_id"] = organization_id

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ChargebackDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_chargeback_details(start_time, end_time, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_chargeback_details.new.run()
    end
end