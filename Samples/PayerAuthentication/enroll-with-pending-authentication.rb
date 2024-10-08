require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Enroll_with_pending_authentication
    def run()
        request_obj = CyberSource::CheckPayerAuthEnrollmentRequest.new
        client_reference_information = CyberSource::Riskv1authenticationsetupsClientReferenceInformation.new
        client_reference_information.code = "cybs_test"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1authenticationsOrderInformation.new
        amount_details = CyberSource::Riskv1authenticationsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "10.99"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Riskv1authenticationsOrderInformationBillTo.new
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

        payment_information = CyberSource::Riskv1authenticationsPaymentInformation.new
        card = CyberSource::Riskv1authenticationsetupsPaymentInformationCard.new
        card.type = "001"
        card.expiration_month = "12"
        card.expiration_year = "2025"
        card.number = "4000000000000101"
        payment_information.card = card
        request_obj.payment_information = payment_information

        buyer_information = CyberSource::Riskv1authenticationsBuyerInformation.new
        buyer_information.mobile_phone = 1245789632
        request_obj.buyer_information = buyer_information

        consumer_authentication_information = CyberSource::Riskv1decisionsConsumerAuthenticationInformation.new
        consumer_authentication_information.transaction_mode = "MOTO"
        request_obj.consumer_authentication_information = consumer_authentication_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.check_payer_auth_enrollment(request_obj)

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
        Enroll_with_pending_authentication.new.run()
    end
end
