require 'cybersource_rest_client'
require_relative '../Capture/capture-payment.rb'
require_relative '../../../data/Configuration.rb'

public
class void_capture
    def run()
        id = (JSON.parse(capture_payment.new.run))['id']
        request_obj = CyberSource::VoidCaptureRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidreversalsClientReferenceInformation.new
        client_reference_information.code = "test_void"
        request_obj.client_reference_information = client_reference_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VoidApi.new(api_client, config)

        data, status_code, headers = api_instance.void_capture(request_obj, id)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        void_capture.new.run()
    end
end
