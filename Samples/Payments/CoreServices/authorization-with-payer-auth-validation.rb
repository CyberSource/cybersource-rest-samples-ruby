require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class authorization_with_payer_auth_validation
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new

        action_list =  []
        action_list << "VALIDATE_CONSUMER_AUTHENTICATION"
        processing_information.action_list = action_list
        processing_information.capture = false
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4000000000001091"
        card.expiration_month = "01"
        card.expiration_year = "2023"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Smith"
        bill_to.address1 = "201 S. Division St._1"
        bill_to.address2 = "Suite 500"
        bill_to.locality = "Foster City"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94404"
        bill_to.country = "US"
        bill_to.email = "accept@cybs.com"
        bill_to.phone_number = "6504327113"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        consumer_authentication_information = CyberSource::Ptsv2paymentsConsumerAuthenticationInformation.new
        consumer_authentication_information.authentication_transaction_id = "OiCtXA1j1AxtSNDh5lt1"
        request_obj.consumer_authentication_information = consumer_authentication_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        authorization_with_payer_auth_validation.new.run()
    end
end
