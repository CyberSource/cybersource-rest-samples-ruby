require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_amex_direct
    def run()
       
        req_obj = CyberSource::PostRegistrationBody.new

        # Setup Organization Information
        organization_information = CyberSource::Boardingv1registrationsOrganizationInformation.new
        organization_information.parent_organization_id = "apitester00"
        organization_information.type = "MERCHANT"
        organization_information.configurable = true

        # Setup Business Information
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

        # Setup Business Contact
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
        common.merchant_category_code = "1799"
        merchant_descriptor_information = CyberSource::CardProcessingConfigCommonMerchantDescriptorInformation.new
        merchant_descriptor_information.city = "Cupertino"
        merchant_descriptor_information.country = "USA"
        merchant_descriptor_information.name = "Mer name"
        merchant_descriptor_information.phone = "8885554444"
        merchant_descriptor_information.zip = "94043"
        merchant_descriptor_information.state = "CA"
        merchant_descriptor_information.street = "mer street"
        merchant_descriptor_information.url = "www.test.com"

        common.merchant_descriptor_information = merchant_descriptor_information

        common.sub_merchant_id = "123457"
        common.sub_merchant_business_name = "bus name"

        processors = {}
        obj2 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new

        obj2.acquirer = acquirer
        currencies = {}
        obj3 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj3.enabled = true
        obj3.enabled_card_present = true
        obj3.terminal_id = ""
        obj3.service_enablement_number = "1234567890"
        currencies["AED"] = obj3
        currencies["FJD"] = obj3
        currencies["USD"] = obj3

        obj2.currencies = currencies

        payment_types = {}
        obj4 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj4.enabled = true
        payment_types["AMERICAN_EXPRESS"] = obj4

        obj2.payment_types = payment_types
        obj2.allow_multiple_bills = false
        obj2.avs_format = "basic"
        obj2.batch_group = "amexdirect_vme_default"
        obj2.enable_auto_auth_reversal_after_void = false
        obj2.enhanced_data = "disabled"
        obj2.enable_level2 = false
        obj2.amex_transaction_advice_addendum1 = "amex123"
        processors["acquirer"] = obj2

        common.processors = processors
        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new
        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new

        processors3 = {}
        obj5 = CyberSource::CardProcessingConfigFeaturesCardNotPresentProcessors.new
        obj5.relax_address_verification_system = true
        obj5.relax_address_verification_system_allow_expired_card = true
        obj5.relax_address_verification_system_allow_zip_without_country = false
        processors3["amexdirect"] = obj5

        card_not_present.processors = processors3
        features2.card_not_present = card_not_present
        configurations.features = features2
        configuration_information.configurations = configurations
        template_id = "2B80A3C7-5A39-4CC3-9882-AC4A828D3646"
        configuration_information.template_id = template_id
        card_processing.configuration_information = configuration_information
        payments.card_processing = card_processing

        virtual_terminal = CyberSource::PaymentsProductsVirtualTerminal.new
        subscription_information2 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new

        subscription_information2.enabled = true
        virtual_terminal.subscription_information = subscription_information2

        configuration_information3 = CyberSource::PaymentsProductsVirtualTerminalConfigurationInformation.new

        template_id2 = "9FA1BB94-5119-48D3-B2E5-A81FD3C657B5"
        configuration_information3.template_id = template_id2
        virtual_terminal.configuration_information = configuration_information3
        payments.virtual_terminal = virtual_terminal

        customer_invoicing = CyberSource::PaymentsProductsTax.new
        subscription_information6 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new

        subscription_information6.enabled = true
        customer_invoicing.subscription_information = subscription_information6
        payments.customer_invoicing = customer_invoicing
        selected_products.payments = payments

        risk = CyberSource::RiskProducts.new
        selected_products.risk = risk

        commerce_solutions = CyberSource::CommerceSolutionsProducts.new
        token_management = CyberSource::CommerceSolutionsProductsTokenManagement.new

        subscription_information7 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new

        subscription_information7.enabled = true
        token_management.subscription_information = subscription_information7
        configuration_information4 = CyberSource::CommerceSolutionsProductsTokenManagementConfigurationInformation.new

        template_id3 = "D62BEE20-DCFD-4AA2-8723-BA3725958ABA"
        configuration_information4.template_id = template_id3
        token_management.configuration_information = configuration_information4
        commerce_solutions.token_management = token_management
        selected_products.commerce_solutions = commerce_solutions

        value_added_services = CyberSource::ValueAddedServicesProducts.new
        transaction_search = CyberSource::PaymentsProductsTax.new
        subscription_information8 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new

        subscription_information8.enabled = true
        transaction_search.subscription_information = subscription_information8

        value_added_services.transaction_search = transaction_search
        reporting = CyberSource::PaymentsProductsTax.new
        subscription_information9 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new

        subscription_information9.enabled = true
        reporting.subscription_information = subscription_information9
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

        Merchant_boarding_amex_direct.new.run()
    end
end
