require 'cybersource_rest_client'
require_relative './create-instrument-identifier-card.rb'
require_relative '../../../data/Configuration.rb'

public
class retrieve_all_payment_instruments
    def run()
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
	token_id = (JSON.parse(create_instrument_identifier_card.new.run))['id']
        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.get_all_payment_instruments(profileid, token_id, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        retrieve_all_payment_instruments.new.run()
    end
end