require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_payment_batch_summary_data
    def run()
        start_time = "2020-09-01T12:00:00Z"
        end_time = "2020-09-30T12:00:00Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentBatchSummariesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_payment_batch_summary(start_time, end_time, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_payment_batch_summary_data.new.run()
    end
end
