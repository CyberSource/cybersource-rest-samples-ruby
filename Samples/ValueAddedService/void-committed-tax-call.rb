require 'cybersource_rest_client'
require_relative './committed-tax-call-request.rb'
require_relative '../../data/Configuration.rb'

public
class Void_committed_tax_call
    def run()
        id = (JSON.parse(Committed_tax_call_request.new.run()))['id']
        request_obj = CyberSource::VoidTaxRequest.new
        client_reference_information = CyberSource::Vasv2taxidClientReferenceInformation.new
        client_reference_information.code = "TAX_TC001"
        request_obj.client_reference_information = client_reference_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TaxesApi.new(api_client, config)

        data, status_code, headers = api_instance.void_tax(request_obj, id)

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
        Void_committed_tax_call.new.run()
    end
end
