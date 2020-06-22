require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Retrieve_customer_payment_instrument
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = "A822E6E50ED5C604E05341588E0A12EC"
	payment_instrument_token_id = "A823339844A25949E05340588D0A69FB"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerPaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.get_customer_payment_instrument(customer_token_id, payment_instrument_token_id, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Retrieve_customer_payment_instrument.new.run()
    end
end
