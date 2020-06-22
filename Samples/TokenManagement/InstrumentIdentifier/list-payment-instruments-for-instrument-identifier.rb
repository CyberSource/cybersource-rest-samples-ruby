require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class List_payment_instruments_for_instrument_identifier
    def run()
        opts = {}
        opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
        instrument_identifier_token_id = "7010000000016241111"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.get_instrument_identifier_payment_instruments_list(instrument_identifier_token_id, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        List_payment_instruments_for_instrument_identifier.new.run()
    end
end
