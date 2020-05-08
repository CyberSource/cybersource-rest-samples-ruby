require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class level_ii_data
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_12"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.commerce_indicator = "internet"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.type = "001"
        card.security_code = "123"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "112.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "san francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        order_information.bill_to = bill_to
        invoice_details = CyberSource::Ptsv2paymentsOrderInformationInvoiceDetails.new
        invoice_details.purchase_order_number = "LevelII Auth Po"
        order_information.invoice_details = invoice_details
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

        level_ii_data.new.run()
    end
end
