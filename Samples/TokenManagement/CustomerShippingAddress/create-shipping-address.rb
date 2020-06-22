require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_shipping_address
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = "A822E6E50ED5C604E05341588E0A12EC"
        request_obj = CyberSource::PostCustomerShippingAddressRequest.new
        ship_to = CyberSource::Tmsv2customersEmbeddedDefaultShippingAddressShipTo.new
        ship_to.first_name = "John"
        ship_to.last_name = "Doe"
        ship_to.company = "CyberSource"
        ship_to.address1 = "1 Market St"
        ship_to.locality = "San Francisco"
        ship_to.administrative_area = "CA"
        ship_to.postal_code = "94105"
        ship_to.country = "US"
        ship_to.email = "test@cybs.com"
        ship_to.phone_number = "4158880000"
        request_obj.ship_to = ship_to

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerShippingAddressApi.new(api_client, config)

        data, status_code, headers = api_instance.post_customer_shipping_address(customer_token_id, request_obj, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_shipping_address.new.run()
    end
end
