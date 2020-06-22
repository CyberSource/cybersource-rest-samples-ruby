require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative './create-shipping-address.rb'

public
class Delete_customer_shipping_address
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = "A822E6E50ED5C604E05341588E0A12EC"
	shipping_address_token_id = (JSON.parse(Create_shipping_address.new.run())['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerShippingAddressApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_customer_shipping_address(customer_token_id, shipping_address_token_id, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Delete_customer_shipping_address.new.run()
    end
end
