require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_unified_checkout_capture_context
    def run()
        request_obj = CyberSource::GenerateUnifiedCheckoutCaptureContextRequest.new

        target_origins =  []
        target_origins << "https://the-up-demo.appspot.com"
        request_obj.target_origins = target_origins
        request_obj.client_version = "0.11"

        allowed_card_networks =  []
        allowed_card_networks << "VISA"
        allowed_card_networks << "MASTERCARD"
        allowed_card_networks << "AMEX"
        request_obj.allowed_card_networks = allowed_card_networks

        allowed_payment_types =  []
        allowed_payment_types << "PANENTRY"
        allowed_payment_types << "SRC"
        request_obj.allowed_payment_types = allowed_payment_types
        request_obj.country = "US"
        request_obj.locale = "en_US"
		capture_mandate = CyberSource::Upv1capturecontextsCaptureMandate.new
		capture_mandate.billing_type = "FULL"
		capture_mandate.request_email = true
		capture_mandate.request_phone = true
		capture_mandate.request_shipping = true
		capture_mandate.ship_to_countries = ["US", "GB"]
		capture_mandate.show_accepted_network_icons = true
        request_obj.capture_mandate = capture_mandate
        order_information = CyberSource::Upv1capturecontextsOrderInformation.new
        amount_details = CyberSource::Upv1capturecontextsOrderInformationAmountDetails.new
        amount_details.total_amount = "21.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::UnifiedCheckoutCaptureContextApi.new(api_client, config)

        data, status_code, headers = api_instance.generate_unified_checkout_capture_context(request_obj)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Generate_unified_checkout_capture_context.new.run()
    end
end