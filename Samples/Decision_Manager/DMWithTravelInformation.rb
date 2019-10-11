require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class DMWithTravelInformation
    def run()
        request_obj = CyberSource::CreateDecisionManagerCaseRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "54323007"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Riskv1decisionsPaymentInformation.new
        card = CyberSource::Riskv1decisionsPaymentInformationCard.new
        card.number = "4444444444444448"
        card.expiration_month = "12"
        card.expiration_year = "2020"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Riskv1decisionsOrderInformation.new
        amount_details = CyberSource::Riskv1decisionsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "144.14"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Riskv1decisionsOrderInformationBillTo.new
        bill_to.address1 = "96, powers street"
        bill_to.administrative_area = "NH"
        bill_to.country = "US"
        bill_to.locality = "Clearwater milford"
        bill_to.first_name = "James"
        bill_to.last_name = "Smith"
        bill_to.phone_number = "7606160717"
        bill_to.email = "test@visa.com"
        bill_to.postal_code = "03055"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        travel_information = CyberSource::Riskv1decisionsTravelInformation.new
        travel_information.complete_route = "SFO-JFK:JFK-BLR"
        travel_information.departure_time = "2011-03-20 11:30pm GMT"
        travel_information.journey_type = "One way"

        legs = []
        legs1 = CyberSource::Riskv1decisionsTravelInformationLegs.new
        legs1.origination = "SFO"
        legs1.destination = "JFK"
        legs << legs1

        legs2 = CyberSource::Riskv1decisionsTravelInformationLegs.new
        legs2.origination = "JFK"
        legs2.destination = "BLR"
        legs << legs2

        travel_information.legs = legs
        request_obj.travel_information = travel_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DecisionManagerApi.new(api_client, config)

        data, status_code, headers = api_instance.create_decision_manager_case(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        DMWithTravelInformation.new.run()
    end
end
