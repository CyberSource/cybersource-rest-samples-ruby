require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class get_payment_batch_summary_data
    def run()
        start_time = "2019-05-01T12:00:00Z"
        end_time = "2019-08-30T12:00:00Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentBatchSummariesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_payment_batch_summary(start_time, end_time, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        get_payment_batch_summary_data.new.run()
    end
end
