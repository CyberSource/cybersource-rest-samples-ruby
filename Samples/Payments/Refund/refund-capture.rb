require 'cybersource_rest_client'
require_relative '../Capture/capture-payment.rb'
require_relative '../../../data/Configuration.rb'

public
class Refund_capture
    def run()
        id = (JSON.parse(Capture_payment.new.run))['id']
        request_obj = CyberSource::RefundCaptureRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "102.21"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::RefundApi.new(api_client, config)

        data, status_code, headers = api_instance.refund_capture(request_obj, id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Refund_capture.new.run()
    end
end
