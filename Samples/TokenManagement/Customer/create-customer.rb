require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_customer
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
        request_obj = CyberSource::PostCustomerRequest.new
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

        data, status_code, headers = api_instance.post_customer(request_obj, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_customer.new.run()
    end
end
