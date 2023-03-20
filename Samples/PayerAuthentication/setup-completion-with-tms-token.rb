require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Setup_completion_with_tms_token
    def run()
        request_obj = CyberSource::PayerAuthSetupRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "cybs_test"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Riskv1authenticationsetupsPaymentInformation.new
        customer = CyberSource::Riskv1authenticationsetupsPaymentInformationCustomer.new
        customer.customer_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        payment_information.customer = customer
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.payer_auth_setup(request_obj)

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

        Setup_completion_with_tms_token.new.run()
    end
end
