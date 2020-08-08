require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Authorization_with_pa_enroll_authentication_needed
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new

        action_list =  []
        action_list << "CONSUMER_AUTHENTICATION"
        processing_information.action_list = action_list
        processing_information.capture = false
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4000000000001091"
        card.expiration_month = "12"
        card.expiration_year = "2023"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100.00"
        amount_details.currency = "usd"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Smith"
        bill_to.address1 = "201 S. Division St._1"
        bill_to.address2 = "Suite 500"
        bill_to.locality = "Foster City"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94404"
        bill_to.country = "US"
        bill_to.email = "accept@cybersource.com"
        bill_to.phone_number = "6504327113"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        consumer_authentication_information = CyberSource::Ptsv2paymentsConsumerAuthenticationInformation.new
        consumer_authentication_information.requestor_id = "123123197675"
        consumer_authentication_information.reference_id = "CybsCruiseTester-8ac0b02f"
        request_obj.consumer_authentication_information = consumer_authentication_information

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

        Authorization_with_pa_enroll_authentication_needed.new.run()
    end
end
