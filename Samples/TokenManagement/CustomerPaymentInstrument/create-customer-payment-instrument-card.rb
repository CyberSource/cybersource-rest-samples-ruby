require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_customer_payment_instrument_card
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        request_obj = CyberSource::PostCustomerPaymentInstrumentRequest.new
        card = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentCard.new
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.type = "001"
        request_obj.card = card

        bill_to = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.company = "CyberSource"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "San Francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        request_obj.bill_to = bill_to

        instrument_identifier = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentInstrumentIdentifier.new
        instrument_identifier.id = "7010000000016241111"
        request_obj.instrument_identifier = instrument_identifier

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerPaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.post_customer_payment_instrument(customer_token_id, request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_customer_payment_instrument_card.new.run()
    end
end
