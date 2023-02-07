require 'cybersource_rest_client'
require_relative '../Payments/simple-authorizationinternet.rb'
require_relative '../../../data/Configuration.rb'

public
class Refund_payment
    def run()
        id = (JSON.parse(Simple_authorizationinternet.new.run(true)))['id']
        request_obj = CyberSource::RefundPaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidrefundsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "10"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::RefundApi.new(api_client, config)

        data, status_code, headers = api_instance.refund_payment(request_obj, id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Refund_payment.new.run()
    end
end
