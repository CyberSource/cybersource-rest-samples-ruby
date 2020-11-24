require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Enroll_instrument_identifier_for_network_tokenization
    def run()
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
        instrument_identifier_token_id = '7010000000016241111'

        request_obj = CyberSource::PostInstrumentIdentifierRequest.new
        request_obj.type = "enrollable card"
        card = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierCard.new
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.security_code = "123"
        request_obj.card = card

        bill_to = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierBillTo.new
        bill_to.address1 = "1 Market St"
        bill_to.locality = "San Francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        request_obj.bill_to = bill_to

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.post_instrument_identifier_enrollment(instrument_identifier_token_id, request_obj, profileid)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Enroll_instrument_identifier_for_network_tokenization.new.run()
    end
end
