require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_instrument_identifier_card
    def run()
        opts = {}
        opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
        request_obj = CyberSource::PostInstrumentIdentifierRequest.new
        card = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierCard.new
        card.number = "4111111111111111"
        request_obj.card = card

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.post_instrument_identifier(request_obj, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_instrument_identifier_card.new.run()
    end
end
