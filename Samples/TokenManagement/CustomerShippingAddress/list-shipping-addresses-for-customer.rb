require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class List_shipping_addresses_for_customer
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerShippingAddressApi.new(api_client, config)

        data, status_code, headers = api_instance.get_customer_shipping_addresses_list(customer_token_id)

        puts data, status_code, headers

        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        List_shipping_addresses_for_customer.new.run()
    end
end
