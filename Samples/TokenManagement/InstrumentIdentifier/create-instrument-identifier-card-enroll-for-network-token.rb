require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class create_instrument_identifier_card_enroll_for_network_token
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
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
        create_instrument_identifier_card_enroll_for_network_token.new.run(profileid)
    end
end
