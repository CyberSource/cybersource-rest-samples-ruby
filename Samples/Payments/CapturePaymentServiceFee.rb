require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class CapturePaymentServiceFee
    def run(id)
        request_obj = CyberSource::CapturePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Ptsv2paymentsidcapturesOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "2325.00"
        amount_details.currency = "USD"
        amount_details.service_fee_amount = "30.0"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsidcapturesMerchantInformation.new
        service_fee_descriptor = CyberSource::Ptsv2paymentsMerchantInformationServiceFeeDescriptor.new
        service_fee_descriptor.name = "Vacations Service Fee"
        service_fee_descriptor.contact = "8009999999"
        service_fee_descriptor.state = "CA"
        merchant_information.service_fee_descriptor = service_fee_descriptor
        request_obj.merchant_information = merchant_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CaptureApi.new(api_client, config)

        data, status_code, headers = api_instance.capture_payment(request_obj, id)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <id>:"
        id = gets.chomp

        CapturePaymentServiceFee.new.run(id)
    end
end
