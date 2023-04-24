require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Retrieve_customer_payment_instrument
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        payment_instrument_token_id = "AB6A54B982A6FCB6E05341588E0A3935"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerPaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.get_customer_payment_instrument(customer_token_id, payment_instrument_token_id)

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
        Retrieve_customer_payment_instrument.new.run()
    end
end
