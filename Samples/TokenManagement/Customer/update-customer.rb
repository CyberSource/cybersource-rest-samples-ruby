require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Update_customer
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        request_obj = CyberSource::PatchCustomerRequest.new
        buyer_information = CyberSource::Tmsv2customersBuyerInformation.new
        buyer_information.merchant_customer_id = "Your customer identifier"
        buyer_information.email = "test@cybs.com"
        request_obj.buyer_information = buyer_information

        client_reference_information = CyberSource::Tmsv2customersClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information


        merchant_defined_information = []
        merchant_defined_information1 = CyberSource::Tmsv2customersMerchantDefinedInformation.new
        merchant_defined_information1.name = "data1"
        merchant_defined_information1.value = "Your customer data"
        merchant_defined_information << merchant_defined_information1

        request_obj.merchant_defined_information = merchant_defined_information
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerApi.new(api_client, config)

        data, status_code, headers = api_instance.patch_customer(customer_token_id, request_obj)

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
        Update_customer.new.run()
    end
end
