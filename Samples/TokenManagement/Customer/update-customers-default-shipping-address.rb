require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Update_customers_default_shipping_address
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        request_obj = CyberSource::PatchCustomerRequest.new
        default_shipping_address = CyberSource::Tmsv2customersDefaultShippingAddress.new
        default_shipping_address.id = "AB6A54B97C00FCB6E05341588E0A3935"
        request_obj.default_shipping_address = default_shipping_address

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerApi.new(api_client, config)

        data, status_code, headers = api_instance.patch_customer(customer_token_id, request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Update_customers_default_shipping_address.new.run()
    end
end
