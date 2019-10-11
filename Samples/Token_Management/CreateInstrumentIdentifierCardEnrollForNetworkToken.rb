require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class CreateInstrumentIdentifierCardEnrollForNetworkToken
    def run(profileid)
        request_obj = CyberSource::CreateInstrumentIdentifierRequest.new
        request_obj.type = "enrollable card"
        card = CyberSource::Tmsv1instrumentidentifiersCard.new
        card.number = "4622943127013705"
        card.expiration_month = "12"
        card.expiration_year = "2022"
        card.security_code = "838"
        request_obj.card = card

        bill_to = CyberSource::Tmsv1instrumentidentifiersBillTo.new
        bill_to.address1 = "8310 Capital of Texas Highway North"
        bill_to.address2 = "Bluffstone Drive"
        bill_to.locality = "Austin"
        bill_to.administrative_area = "TX"
        bill_to.postal_code = "78731"
        bill_to.country = "US"
        request_obj.bill_to = bill_to

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.create_instrument_identifier(profileid, request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing header parameter <profile-id>:"
        profileid = gets.chomp

        CreateInstrumentIdentifierCardEnrollForNetworkToken.new.run(profileid)
    end
end
