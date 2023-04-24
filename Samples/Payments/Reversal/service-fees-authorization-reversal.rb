require 'cybersource_rest_client'
require_relative '../Payments/service-fees-with-credit-card-transaction.rb'
require_relative '../../../data/Configuration.rb'

public
class Service_fees_authorization_reversal
    def run()
        id = (JSON.parse(Service_fees_with_credit_card_transaction.new.run(false)))['id']
        request_obj = CyberSource::AuthReversalRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidreversalsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        reversal_information = CyberSource::Ptsv2paymentsidreversalsReversalInformation.new
        amount_details = CyberSource::Ptsv2paymentsidreversalsReversalInformationAmountDetails.new
        amount_details.total_amount = "2325.00"
        reversal_information.amount_details = amount_details
        reversal_information.reason = "34"
        request_obj.reversal_information = reversal_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReversalApi.new(api_client, config)

        data, status_code, headers = api_instance.auth_reversal(id, request_obj)

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
        Service_fees_authorization_reversal.new.run()
    end
end
