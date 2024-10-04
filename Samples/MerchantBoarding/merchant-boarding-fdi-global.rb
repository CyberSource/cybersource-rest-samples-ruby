require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_fdi_global
    def run()
       
       
        req_obj = CyberSource::PostRegistrationBody.new

        organization_information = CyberSource::Boardingv1registrationsOrganizationInformation.new
        organization_information.parent_organization_id = "apitester00"
        organization_information.type = "MERCHANT"
        organization_information.configurable = true

        business_information = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformation.new
        business_information.name = "StuartWickedFastEatz"
        address = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformationAddress.new
        address.country = "US"
        address.address1 = "123456 SandMarket"
        address.locality = "ORMOND BEACH"
        address.administrative_area = "FL"
        address.postal_code = "32176"
        business_information.address = address
        business_information.website_url = "https://www.StuartWickedEats.com"
        business_information.phone_number = "6574567813"

        business_contact = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformationBusinessContact.new
        business_contact.first_name = "Stuart"
        business_contact.last_name = "Stuart"
        business_contact.phone_number = "6574567813"
        business_contact.email = "svc_email_bt@corpdev.visa.com"
        business_information.business_contact = business_contact
        business_information.merchant_category_code = "5999"
        organization_information.business_information = business_information

        req_obj.organization_information = organization_information

        product_information = CyberSource::Boardingv1registrationsProductInformation.new
        selected_products = CyberSource::Boardingv1registrationsProductInformationSelectedProducts.new

        payments = CyberSource::PaymentsProducts.new
        card_processing = CyberSource::PaymentsProductsCardProcessing.new
        subscription_information = CyberSource::PaymentsProductsCardProcessingSubscriptionInformation.new

        subscription_information.enabled = true
        features = {}

        obj1 = CyberSource::PaymentsProductsCardProcessingSubscriptionInformationFeatures.new
        obj1.enabled = true
        features["cardNotPresent"] = obj1
        features["cardPresent"] = obj1
        subscription_information.features = features
        card_processing.subscription_information = subscription_information

        configuration_information = CyberSource::PaymentsProductsCardProcessingConfigurationInformation.new

        configurations = CyberSource::CardProcessingConfig.new
        common = CyberSource::CardProcessingConfigCommon.new
        common.merchant_category_code = "0742"
        common.default_auth_type_code = "PRE"
        common.process_level3_data = "ignored"
        common.master_card_assigned_id = "123456789"
        common.enable_partial_auth = true

        processors = {}
        obj5 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new

        obj5.acquirer = acquirer

        currencies = {}

        obj6 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj6.enabled = true
        obj6.enabled_card_present = false
        obj6.enabled_card_not_present = true
        obj6.merchant_id = "123456789mer"
        obj6.terminal_id = "12345ter"
        obj6.service_enablement_number = ""
        currencies["CHF"] = obj6
        currencies["HRK"] = obj6
        currencies["ERN"] = obj6
        currencies["USD"] = obj6

        obj5.currencies = currencies

        payment_types = {}
        obj7 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj7.enabled = true
        payment_types["MASTERCARD"] = obj7
        payment_types["DISCOVER"] = obj7
        payment_types["JCB"] = obj7
        payment_types["VISA"] = obj7
        payment_types["AMERICAN_EXPRESS"] = obj7
        payment_types["DINERS_CLUB"] = obj7
        payment_types["CUP"] = obj7
        currencies2 = {}
        ob1 = CyberSource::CardProcessingConfigCommonCurrencies.new
        ob1.enabled = true
        ob1.terminal_id = "pint123"
        ob1.merchant_id = "pinm123"
        ob1.service_enablement_number = nil

        currencies2["USD"] = ob1
        obj7.currencies = currencies2
        payment_types["PIN_DEBIT"] = obj7

        obj5.payment_types = payment_types
        obj5.batch_group = "fdiglobal_vme_default"
        obj5.enhanced_data = "disabled"
        obj5.enable_pos_network_switching = true
        obj5.enable_transaction_reference_number = true

        processors["fdiglobal"] = obj5

        common.processors = processors
        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new

        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new

        processors3 = {}
        obj9 = CyberSource::CardProcessingConfigFeaturesCardNotPresentProcessors.new

        obj9.relax_address_verification_system = true
        obj9.relax_address_verification_system_allow_expired_card = true
        obj9.relax_address_verification_system_allow_zip_without_country = true

        processors3["fdiglobal"] = obj9
        card_not_present.processors = processors3

        card_not_present.visa_straight_through_processing_only = true
        card_not_present.amex_transaction_advice_addendum1 = "amex12345"
        card_not_present.ignore_address_verification_system = true
        features2.card_not_present = card_not_present

        configurations.features = features2
        configuration_information.configurations = configurations
        template_id = "685A1FC9-3CEC-454C-9D8A-19205529CE45"
        configuration_information.template_id = template_id

        card_processing.configuration_information = configuration_information
        payments.card_processing = card_processing
        selected_products.payments = payments

        product_information.selected_products = selected_products
        req_obj.product_information = product_information
        

        config = MerchantBoardingConfiguration.new.merchantBoardingConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::MerchantBoardingApi.new(api_client, config)

        data, status_code, headers = api_instance.post_registration(req_obj)

        puts data, status_code, headers
        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0

        Merchant_boarding_fdi_global.new.run()
    end
end
