require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative '../Payments/authorization-for-timeout-reversal-flow.rb'

public
class Timeout_reversal
    def run()
        auth_flow = Authorization_for_timeout_reversal_flow.new
        id = (JSON.parse(auth_flow.run()))['id']
        
        request_obj = CyberSource::MitReversalRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        client_reference_information.transaction_id = auth_flow.timeoutReversalTransactionId
        request_obj.client_reference_information = client_reference_information

        reversal_information = CyberSource::Ptsv2paymentsidreversalsReversalInformation.new
        amount_details = CyberSource::Ptsv2paymentsidreversalsReversalInformationAmountDetails.new
        amount_details.total_amount = "102.21"
        reversal_information.amount_details = amount_details
        reversal_information.reason = "testing"
        request_obj.reversal_information = reversal_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReversalApi.new(api_client, config)

        data, status_code, headers = api_instance.mit_reversal(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Timeout_reversal.new.run()
    end
end
