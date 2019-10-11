require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class ProcessPaymentWithApplePay
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC_1231223"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = FALSE
        processing_information.commerce_indicator = "internet"
        processing_information.payment_solution = "001"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        tokenized_card = CyberSource::Ptsv2paymentsPaymentInformationTokenizedCard.new
        tokenized_card.number = "4111111111111111"
        tokenized_card.expiration_month = "12"
        tokenized_card.expiration_year = "2031"
        tokenized_card.cryptogram = "AceY+igABPs3jdwNaDg3MAACAAA="
        tokenized_card.transaction_type = "1"
        payment_information.tokenized_card = tokenized_card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "10"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Deo"
        bill_to.address1 = "901 Metro Center Blvd"
        bill_to.address2 = "Desk M3-5573"
        bill_to.locality = "Foster City"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94404"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "6504327113"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        ProcessPaymentWithApplePay.new.run()
    end
end
