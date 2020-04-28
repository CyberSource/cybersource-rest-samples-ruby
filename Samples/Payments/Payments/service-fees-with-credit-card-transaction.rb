require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Service_fees_with_credit_card_transaction
    def run(flag)
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        if flag == true
            processing_information.capture = true
        end
        processing_information.commerce_indicator = "internet"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.security_code = "123"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "2325.00"
        amount_details.currency = "USD"
        amount_details.service_fee_amount = "30.00"
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
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsMerchantInformation.new
        service_fee_descriptor = CyberSource::Ptsv2paymentsMerchantInformationServiceFeeDescriptor.new
        service_fee_descriptor.name = "Vacations Service Fee"
        service_fee_descriptor.contact = "8009999999"
        service_fee_descriptor.state = "CA"
        merchant_information.service_fee_descriptor = service_fee_descriptor
        request_obj.merchant_information = merchant_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Service_fees_with_credit_card_transaction.new.run(true)
    end
end
