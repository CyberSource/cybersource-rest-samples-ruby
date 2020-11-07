require 'cybersource_rest_client'
require_relative './create-customer-non-default-shipping-address.rb'
require_relative '../../../data/Configuration.rb'

public
class Delete_customer_shipping_address
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        shipping_address_token_id = (JSON.parse(Create_customer_non_default_shipping_address.new.run()))['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerShippingAddressApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_customer_shipping_address(customer_token_id, shipping_address_token_id)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Delete_customer_shipping_address.new.run()
    end
end
