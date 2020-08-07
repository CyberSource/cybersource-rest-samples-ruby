require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative '../Payments/restaurant-authorization.rb'

public
class Restaurant_capture_with_gratuity
    def run()
        id = JSON.parse(Restaurant_authorization.new.run())['id']
        request_obj = CyberSource::CapturePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "1234567890"
        partner = CyberSource::Ptsv2paymentsClientReferenceInformationPartner.new
        partner.third_party_certification_number = "123456789012"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsidcapturesProcessingInformation.new
        processing_information.industry_data_type = "restaurant"
        request_obj.processing_information = processing_information

        order_information = CyberSource::Ptsv2paymentsidcapturesOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "100"
        amount_details.currency = "USD"
        amount_details.gratuity_amount = "11.50"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CaptureApi.new(api_client, config)

        data, status_code, headers = api_instance.capture_payment(request_obj, id)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Restaurant_capture_with_gratuity.new.run()
    end
end
