require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Generate_unified_checkout_capture_context
    def run()
        request_obj = CyberSource::GenerateUnifiedCheckoutCaptureContextRequest.new

        request_obj.client_version = "0.23"

        target_origins =  []
        target_origins << "https://yourCheckoutPage.com"
        request_obj.target_origins = target_origins

        allowed_card_networks =  []
        allowed_card_networks << "VISA"
        allowed_card_networks << "MASTERCARD"
        allowed_card_networks << "AMEX"
        allowed_card_networks << "CARNET"
        allowed_card_networks << "CARTESBANCAIRES"
        allowed_card_networks << "CUP"
        allowed_card_networks << "DINERSCLUB"
        allowed_card_networks << "DISCOVER"
        allowed_card_networks << "EFTPOS"
        allowed_card_networks << "ELO"
        allowed_card_networks << "JCB"
        allowed_card_networks << "JCREW"
        allowed_card_networks << "MADA"
        allowed_card_networks << "MAESTRO"
        allowed_card_networks << "MEEZA"
        request_obj.allowed_card_networks = allowed_card_networks

        allowed_payment_types =  []
        allowed_payment_types << "CLICKTOPAY"
        request_obj.allowed_payment_types = allowed_payment_types
        request_obj.country = "US"
        request_obj.locale = "en_US"
        capture_mandate = CyberSource::Upv1capturecontextsCaptureMandate.new
        capture_mandate.billing_type = "FULL"
        capture_mandate.request_email = true
        capture_mandate.request_phone = true
        capture_mandate.request_shipping = true

        ship_to_countries =  []
        ship_to_countries << "US"
        ship_to_countries << "GB"
        capture_mandate.ship_to_countries = ship_to_countries
        capture_mandate.show_accepted_network_icons = true
        request_obj.capture_mandate = capture_mandate

        order_information = CyberSource::Upv1capturecontextsOrderInformation.new
        amount_details = CyberSource::Upv1capturecontextsOrderInformationAmountDetails.new
        amount_details.total_amount = "21.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        complete_mandate = CyberSource::Upv1capturecontextsCompleteMandate.new
        complete_mandate.type = "CAPTURE"
        complete_mandate.decision_manager = false
        request_obj.complete_mandate = complete_mandate

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