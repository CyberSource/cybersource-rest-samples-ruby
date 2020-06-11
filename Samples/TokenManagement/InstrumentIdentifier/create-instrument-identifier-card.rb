require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_instrument_identifier_card
    def run(profileid)
        request_obj = CyberSource::CreateInstrumentIdentifierRequest.new
        card = CyberSource::Tmsv1instrumentidentifiersCard.new
        card.number = "411111111111111"
        request_obj.card = card

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.create_instrument_identifier(profileid, request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
        Create_instrument_identifier_card.new.run(profileid)
    end
end
