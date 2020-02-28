require 'cybersource_rest_client'
require_relative '../../../ata/Configuration.rb'

public
class RemoveFromHistory
    def run(id)
        request_obj = CyberSource::FraudMarkingActionRequest.new
        risk_information = CyberSource::Riskv1decisionsidmarkingRiskInformation.new
        marking_details = CyberSource::Riskv1decisionsidmarkingRiskInformationMarkingDetails.new
        marking_details.notes = "Adding this transaction as suspect"
        marking_details.reason = "suspected"
        marking_details.action = "hide"
        risk_information.marking_details = marking_details
        request_obj.risk_information = risk_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::DecisionManagerApi.new(api_client, config)

        data, status_code, headers = api_instance.fraud_update(id, request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        id = "5825489395116729903003"

        RemoveFromHistory.new.run(id)
    end
end
