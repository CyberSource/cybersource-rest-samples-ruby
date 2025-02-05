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
        allowed_payment_types << "APPLEPAY"
        allowed_payment_types << "CHECK"
        allowed_payment_types << "CLICKTOPAY"
        allowed_payment_types << "GOOGLEPAY"
        allowed_payment_types << "PANENTRY"
        allowed_payment_types << "PAZE"
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
        bill_to = CyberSource::Upv1capturecontextsOrderInformationBillTo.new
        bill_to.address1 = "277 Park Avenue"
        bill_to.address2 = "50th Floor"
        bill_to.address3 = "Desk NY-50110"
        bill_to.address4 = "address4"
        bill_to.administrative_area = "NY"
        bill_to.building_number = "buildingNumber"
        bill_to.country = "US"
        bill_to.district = "district"
        bill_to.locality = "New York"
        bill_to.postal_code = "10172"
        company = CyberSource::Upv1capturecontextsOrderInformationBillToCompany.new
        company.name = "Visa Inc"
        company.address1 = "900 Metro Center Blvd"
        company.address2 = "address2"
        company.address3 = "address3"
        company.address4 = "address4"
        company.administrative_area = "CA"
        company.building_number = "1"
        company.country = "US"
        company.district = "district"
        company.locality = "Foster City"
        company.postal_code = "94404"
        bill_to.company = company
        bill_to.email = "john.doe@visa.com"
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.middle_name = "F"
        bill_to.name_suffix = "Jr"
        bill_to.title = "Mr"
        bill_to.phone_number = "1234567890"
        bill_to.phone_type = "phoneType"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Upv1capturecontextsOrderInformationShipTo.new
        ship_to.address1 = "CyberSource"
        ship_to.address2 = "Victoria House"
        ship_to.address3 = "15-17 Gloucester Street"
        ship_to.address4 = "string"
        ship_to.administrative_area = "CA"
        ship_to.building_number = "string"
        ship_to.country = "GB"
        ship_to.district = "string"
        ship_to.locality = "Belfast"
        ship_to.postal_code = "BT1 4LS"
        ship_to.first_name = "Joe"
        ship_to.last_name = "Soap"
        order_information.ship_to = ship_to
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