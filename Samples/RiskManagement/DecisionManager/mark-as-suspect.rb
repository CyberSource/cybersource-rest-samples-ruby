require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Mark_as_suspect
    def run(id)
        request_obj = CyberSource::FraudMarkingActionRequest.new
        risk_information = CyberSource::Riskv1decisionsidmarkingRiskInformation.new
        marking_details = CyberSource::Riskv1decisionsidmarkingRiskInformationMarkingDetails.new
        marking_details.notes = "Adding this transaction as suspect"
        marking_details.reason = "suspected"

        fields_included =  []
        fields_included << "customer_email"
        fields_included << "customer_phone"
        marking_details.fields_included = fields_included
        marking_details.action = "add"
        risk_information.marking_details = marking_details
        request_obj.risk_information = risk_information

        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "12345"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "1234"
        partner.solution_id = "3321"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DecisionManagerApi.new(api_client, config)

        data, status_code, headers = api_instance.fraud_update(id, request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        id = "5880752617506443004004"

        Mark_as_suspect.new.run(id)
    end
end
