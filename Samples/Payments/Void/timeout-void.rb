require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative '../Payments/authorization-capture-for-timeout-void-flow.rb'

public
class Timeout_void
    def run()
        auth_capture_flow = Authorization_capture_for_timeout_void_flow.new
        id = (JSON.parse(auth_capture_flow.run()))['id']
        
        request_obj = CyberSource::MitVoidRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        client_reference_information.transaction_id = auth_capture_flow.timeoutVoidTransactionId
        request_obj.client_reference_information = client_reference_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VoidApi.new(api_client, config)

        data, status_code, headers = api_instance.mit_void(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Timeout_void.new.run()
    end
end
