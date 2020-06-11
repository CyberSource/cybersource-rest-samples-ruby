require 'cybersource_rest_client'
require_relative '../Payments/simple-authorizationinternet.rb'
require_relative '../../../data/Configuration.rb'

public
class Process_authorization_reversal
    def run()
        id = (JSON.parse(Simple_authorizationinternet.new.run(false)))['id']
        request_obj = CyberSource::AuthReversalRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidreversalsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
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

        data, status_code, headers = api_instance.auth_reversal(id, request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Process_authorization_reversal.new.run()
    end
end
