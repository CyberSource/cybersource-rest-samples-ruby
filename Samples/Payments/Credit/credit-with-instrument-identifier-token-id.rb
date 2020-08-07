require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Credit_with_instrument_identifier_token_id
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "12345678"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsidrefundsPaymentInformationCard.new
        card.expiration_month = "03"
        card.expiration_year = "2031"
        card.type = "001"
        payment_information.card = card
        instrument_identifier = CyberSource::Ptsv2paymentsPaymentInformationInstrumentIdentifier.new
        instrument_identifier.id = "7010000000016241111"
        payment_information.instrument_identifier = instrument_identifier
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "200"
        amount_details.currency = "usd"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsidcapturesOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Deo"
        bill_to.address1 = "900 Metro Center Blvd"
        bill_to.locality = "Foster City"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "48104-2201"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "9321499232"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Credit_with_instrument_identifier_token_id.new.run()
    end
end
