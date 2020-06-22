require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Retrieve_customer_shipping_address
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = "A822E6E50ED5C604E05341588E0A12EC"
	shipping_address_token_id = "A8235AC00BC67783E05340588D0A851E"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerShippingAddressApi.new(api_client, config)

        data, status_code, headers = api_instance.get_customer_shipping_address(customer_token_id, shipping_address_token_id, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Retrieve_customer_shipping_address.new.run()
    end
end
