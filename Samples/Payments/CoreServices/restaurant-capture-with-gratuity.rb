require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class restaurant_capture_with_gratuity
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "1234567890"
        partner = CyberSource::Ptsv2paymentsClientReferenceInformationPartner.new
        partner.third_party_certification_number = "123456789012"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.industry_data_type = "restaurant"
        request_obj.processing_information = processing_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100"
        amount_details.currency = "USD"
        amount_details.gratuity_amount = "11.50"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        restaurant_capture_with_gratuity.new.run()
    end
end
