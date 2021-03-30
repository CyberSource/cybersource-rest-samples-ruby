require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Add_data_to_list
    def run(type)
        request_obj = CyberSource::AddNegativeListRequest.new
        order_information = CyberSource::Riskv1liststypeentriesOrderInformation.new
        address = CyberSource::Riskv1liststypeentriesOrderInformationAddress.new
        address.address1 = "1234 Sample St."
        address.address2 = "Mountain View"
        address.locality = "California"
        address.country = "US"
        address.administrative_area = "CA"
        address.postal_code = "94043"
        order_information.address = address
        bill_to = CyberSource::Riskv1liststypeentriesOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.email = "test@example.com"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        payment_information = CyberSource::Riskv1liststypeentriesPaymentInformation.new
        request_obj.payment_information = payment_information

        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "54323007"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "7891234"
        partner.solution_id = "89012345"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        risk_information = CyberSource::Riskv1liststypeentriesRiskInformation.new
        marking_details = CyberSource::Riskv1liststypeentriesRiskInformationMarkingDetails.new
        marking_details.action = "add"
        risk_information.marking_details = marking_details
        request_obj.risk_information = risk_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DecisionManagerApi.new(api_client, config)

        data, status_code, headers = api_instance.add_negative(type, request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        type = "negative"

        Add_data_to_list.new.run(type)
    end
end
