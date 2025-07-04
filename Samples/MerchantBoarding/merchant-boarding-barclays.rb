require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_barclays
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
        common.merchant_category_code = "5999"
        common.default_auth_type_code = "FINAL"
        
        processors = {}
        obj2 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new
        obj2.acquirer = acquirer
        
        currencies = {}
        obj3 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj3.enabled = true
        obj3.enabled_card_present = false
        obj3.enabled_card_not_present = true
        obj3.merchant_id = "1234"
        obj3.service_enablement_number = ""
        terminal_ids = ["12351245"]
        obj3.terminal_ids = terminal_ids
        
        currencies["AED"] = obj3
        currencies["USD"] = obj3
        obj2.currencies = currencies
        
        payment_types = {}
        obj4 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj4.enabled = true
        payment_types["MASTERCARD"] = obj4
        payment_types["VISA"] = obj4
        obj2.payment_types = payment_types
        
        obj2.batch_group = "barclays2_16"
        obj2.quasi_cash = false
        obj2.enhanced_data = "disabled"
        obj2.merchant_id = "124555"
        obj2.enable_multi_currency_processing = "false"
        processors["barclays2"] = obj2
        
        common.processors = processors
        configurations.common = common
        
        features3 = CyberSource::CardProcessingConfigFeatures.new
        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new
        processors4 = {}
        obj6 = CyberSource::CardProcessingConfigFeaturesCardNotPresentProcessors.new
        payouts = CyberSource::CardProcessingConfigFeaturesCardNotPresentPayouts.new
        
        payouts.merchant_id = "1233"
        payouts.terminal_id = "1244"
        obj6.payouts = payouts
        processors4["barclays2"] = obj6
        card_not_present.processors = processors4
        features3.card_not_present = card_not_present
        
        configurations.features = features3
        configuration_information.configurations = configurations
        
        template_id = "0A413572-1995-483C-9F48-FCBE4D0B2E86"
        configuration_information.template_id = template_id
        card_processing.configuration_information = configuration_information
        payments.card_processing = card_processing
        
        virtual_terminal = CyberSource::PaymentsProductsVirtualTerminal.new
        
        configuration_information2 = CyberSource::PaymentsProductsVirtualTerminalConfigurationInformation.new
        template_id3 = "E4EDB280-9DAC-4698-9EB9-9434D40FF60C"
        configuration_information2.template_id = template_id3
        virtual_terminal.configuration_information = configuration_information2
        payments.virtual_terminal = virtual_terminal
        
        customer_invoicing = CyberSource::PaymentsProductsTax.new
        payments.customer_invoicing = customer_invoicing
        
        selected_products.payments = payments
        
        risk2 = CyberSource::RiskProducts.new
        selected_products.risk = risk2
        
        commerce_solutions = CyberSource::CommerceSolutionsProducts.new
        token_management = CyberSource::CommerceSolutionsProductsTokenManagement.new
        
        configuration_information5 = CyberSource::CommerceSolutionsProductsTokenManagementConfigurationInformation.new
        template_id4 = "D62BEE20-DCFD-4AA2-8723-BA3725958ABA"
        configuration_information5.template_id = template_id4
        token_management.configuration_information = configuration_information5
        commerce_solutions.token_management = token_management
        selected_products.commerce_solutions = commerce_solutions
        
        value_added_services = CyberSource::ValueAddedServicesProducts.new
        transaction_search = CyberSource::PaymentsProductsTax.new
        value_added_services.transaction_search = transaction_search
        
        reporting = CyberSource::PaymentsProductsTax.new
        value_added_services.reporting = reporting
        selected_products.value_added_services = value_added_services
        
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

        Merchant_boarding_barclays.new.run()
    end
end
