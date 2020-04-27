require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class enroll_with_pending_authentication
    def run()
        request_obj = CyberSource::CheckPayerAuthEnrollmentRequest.new
        client_reference_information = CyberSource::Riskv1authenticationsetupsClientReferenceInformation.new
        client_reference_information.code = "cybs_test"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1authenticationsOrderInformation.new
        amount_details = CyberSource::Riskv1decisionsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "10.99"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Riskv1authenticationexemptionsOrderInformationBillTo.new
        bill_to.address1 = "1 Market St"
        bill_to.address2 = "Address 2"
        bill_to.administrative_area = "CA"
        bill_to.country = "US"
        bill_to.locality = "san francisco"
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.phone_number = "4158880000"
        bill_to.email = "test@cybs.com"
        bill_to.postal_code = "94105"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        payment_information = CyberSource::Riskv1authenticationexemptionsPaymentInformation.new
        card = CyberSource::Riskv1authenticationexemptionsPaymentInformationCard.new
        card.type = "001"
        card.expiration_month = "12"
        card.expiration_year = "2025"
        card.number = "4000000000000101"
        payment_information.card = card
        request_obj.payment_information = payment_information

        buyer_information = CyberSource::Riskv1authenticationsBuyerInformation.new
        buyer_information.mobile_phone = 1245789632
        request_obj.buyer_information = buyer_information

        consumer_authentication_information = CyberSource::Riskv1authenticationsConsumerAuthenticationInformation.new
        consumer_authentication_information.transaction_mode = "MOTO"
        request_obj.consumer_authentication_information = consumer_authentication_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.check_payer_auth_enrollment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        enroll_with_pending_authentication.new.run()
    end
end
