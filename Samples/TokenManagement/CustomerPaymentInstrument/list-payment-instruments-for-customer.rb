require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class List_payment_instruments_for_customer
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerPaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.get_customer_payment_instruments_list(customer_token_id)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        List_payment_instruments_for_customer.new.run()
    end
end
