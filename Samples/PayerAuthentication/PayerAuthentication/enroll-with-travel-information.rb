require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class enroll_with_travel_information
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
        card.type = "002"
        card.expiration_month = "12"
        card.expiration_year = "2025"
        card.number = "5200340000000015"
        payment_information.card = card
        request_obj.payment_information = payment_information

        buyer_information = CyberSource::Riskv1authenticationsBuyerInformation.new
        buyer_information.mobile_phone = 1245789632
        request_obj.buyer_information = buyer_information

        consumer_authentication_information = CyberSource::Riskv1authenticationsConsumerAuthenticationInformation.new
        consumer_authentication_information.transaction_mode = "MOTO"
        request_obj.consumer_authentication_information = consumer_authentication_information

        travel_information = CyberSource::Riskv1authenticationsTravelInformation.new

        legs = []
        legs1 = CyberSource::Riskv1authenticationsTravelInformationLegs.new
        legs1.destination = "DEFGH"
        legs1.carrier_code = "UA"
        legs1.departure_date = "2019-01-01"
        legs << legs1

        legs2 = CyberSource::Riskv1authenticationsTravelInformationLegs.new
        legs2.destination = "RESD"
        legs2.carrier_code = "AS"
        legs2.departure_date = "2019-02-21"
        legs << legs2

        travel_information.legs = legs
        travel_information.number_of_passengers = 2

        passengers = []
        passengers1 = CyberSource::Riskv1authenticationsTravelInformationPassengers.new
        passengers1.first_name = "Raj"
        passengers1.last_name = "Charles"
        passengers << passengers1

        passengers2 = CyberSource::Riskv1authenticationsTravelInformationPassengers.new
        passengers2.first_name = "Potter"
        passengers2.last_name = "Suhember"
        passengers << passengers2

        travel_information.passengers = passengers
        request_obj.travel_information = travel_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.check_payer_auth_enrollment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        enroll_with_travel_information.new.run()
    end
end
