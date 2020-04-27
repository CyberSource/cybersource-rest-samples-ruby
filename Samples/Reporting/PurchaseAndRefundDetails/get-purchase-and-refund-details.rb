require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class get_purchase_and_refund_details
    def run()
        start_time = "2018-05-01T12:00:00Z"
        end_time = "2018-05-30T12:00:00Z"

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"payment_subtype"] = "VI"
        opts[:"view_by"] = "requestDate"
        opts[:"group_name"] = "groupName"
        opts[:"offset"] = 20
        opts[:"limit"] = 2000

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PurchaseAndRefundDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_purchase_and_refund_details(start_time, end_time, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        get_purchase_and_refund_details.new.run()
    end
end
