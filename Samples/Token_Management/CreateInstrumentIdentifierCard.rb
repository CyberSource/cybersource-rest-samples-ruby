require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class CreateInstrumentIdentifierCard
    def run(profileid)
        request_obj = CyberSource::CreateInstrumentIdentifierRequest.new
        card = CyberSource::Tmsv1instrumentidentifiersCard.new
        card.number = "411111111111112"
        request_obj.card = card

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.create_instrument_identifier(profileid, request_obj)
	puts data
        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing header parameter <profile-id>:"
        profileid = gets.chomp

        CreateInstrumentIdentifierCard.new.run(profileid)
    end
end
