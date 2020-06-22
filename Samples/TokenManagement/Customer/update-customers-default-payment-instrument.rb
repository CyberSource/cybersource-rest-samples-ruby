require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Update_customers_default_payment_instrument
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = "A822E6E50ED5C604E05341588E0A12EC"
        request_obj = CyberSource::PatchCustomerRequest.new
        default_payment_instrument = CyberSource::Tmsv2customersDefaultPaymentInstrument.new
        default_payment_instrument.id = "A83048D587DBFD61E05340588D0A400F"
        request_obj.default_payment_instrument = default_payment_instrument

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerApi.new(api_client, config)

        data, status_code, headers = api_instance.patch_customer(customer_token_id, request_obj, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Update_customers_default_payment_instrument.new.run()
    end
end
