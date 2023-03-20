require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Remove_from_history
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
        id = "5880752617506443004004"

        Remove_from_history.new.run(id)
    end
end
