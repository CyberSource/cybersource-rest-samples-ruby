require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_payment_instrument_card
    def run(profileid)
        request_obj = CyberSource::PostPaymentInstrumentRequest.new
        card = CyberSource::Tmsv2tokenizeTokenInformationCustomerEmbeddedDefaultPaymentInstrumentCard.new
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.type = "visa"
        request_obj.card = card

        bill_to = CyberSource::Tmsv2tokenizeTokenInformationCustomerEmbeddedDefaultPaymentInstrumentBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.company = "Cybersource"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "San Francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        request_obj.bill_to = bill_to

        instrument_identifier = CyberSource::Tmsv2tokenizeTokenInformationCustomerEmbeddedDefaultPaymentInstrumentInstrumentIdentifier.new
        instrument_identifier.id = "7010000000016241111"
        request_obj.instrument_identifier = instrument_identifier

        opts = {}
        opts[:"profile-id"] = profileid

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.post_payment_instrument(request_obj, opts)

        puts data, status_code, headers
        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'

        Create_payment_instrument_card.new.run(profileid)
    end
end
