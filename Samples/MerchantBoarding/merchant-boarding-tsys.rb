require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_tsys
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
        common.merchant_category_code = "5999"
        common.process_level3_data = "ignored"
        common.default_auth_type_code = "FINAL"
        common.enable_partial_auth = false
        common.amex_vendor_code = "2233"

        merchant_descriptor_information = CyberSource::CardProcessingConfigCommonMerchantDescriptorInformation.new
        merchant_descriptor_information.city = "cupertino"
        merchant_descriptor_information.country = "USA"
        merchant_descriptor_information.name = "kumar"
        merchant_descriptor_information.state = "CA"
        merchant_descriptor_information.phone = "888555333"
        merchant_descriptor_information.zip = "94043"
        merchant_descriptor_information.street = "steet1"

        common.merchant_descriptor_information = merchant_descriptor_information

        processors = {}

        obj5 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new
        obj5.acquirer = acquirer

        currencies = {}
        obj6 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj6.enabled = true
        obj6.enabled_card_present = true
        obj6.enabled_card_not_present = true
        obj6.terminal_id = "1234"
        obj6.service_enablement_number = ""

        currencies["CAD"] = obj6
        obj5.currencies = currencies

        payment_types = {}
        obj7 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj7.enabled = true

        payment_types["MASTERCARD"] = obj7
        payment_types["VISA"] = obj7

        obj5.payment_types = payment_types
        obj5.bank_number = "234576"
        obj5.chain_number = "223344"
        obj5.batch_group = "vital_1130"
        obj5.enhanced_data = "disabled"
        obj5.industry_code = "D"
        obj5.merchant_bin_number = "765576"
        obj5.merchant_id = "834215123456"
        obj5.merchant_location_number = "00001"
        obj5.store_id = "2563"
        obj5.vital_number = "71234567"
        obj5.quasi_cash = false
        obj5.send_amex_level2_data = nil
        obj5.soft_descriptor_type = "1 - trans_ref_no"
        obj5.travel_agency_code = "2356"
        obj5.travel_agency_name = "Agent"

        processors["tsys"] = obj5
        common.processors = processors
        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new
        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new
        card_not_present.visa_straight_through_processing_only = false
        card_not_present.amex_transaction_advice_addendum1 = nil

        features2.card_not_present = card_not_present
        configurations.features = features2
        configuration_information.configurations = configurations

        template_id = "818048AD-2860-4D2D-BC39-2447654628A1"
        configuration_information.template_id = template_id
        card_processing.configuration_information = configuration_information
        payments.card_processing = card_processing

        virtual_terminal = CyberSource::PaymentsProductsVirtualTerminal.new

        configuration_information5 = CyberSource::PaymentsProductsVirtualTerminalConfigurationInformation.new
        template_id2 = "9FA1BB94-5119-48D3-B2E5-A81FD3C657B5"
        configuration_information5.template_id = template_id2
        virtual_terminal.configuration_information = configuration_information5
        payments.virtual_terminal = virtual_terminal

        customer_invoicing = CyberSource::PaymentsProductsTax.new
        payments.customer_invoicing = customer_invoicing

        selected_products.payments = payments

        risk = CyberSource::RiskProducts.new
        selected_products.risk = risk

        commerce_solutions = CyberSource::CommerceSolutionsProducts.new
        token_management = CyberSource::CommerceSolutionsProductsTokenManagement.new

        configuration_information7 = CyberSource::CommerceSolutionsProductsTokenManagementConfigurationInformation.new
        template_id3 = "D62BEE20-DCFD-4AA2-8723-BA3725958ABA"
        configuration_information7.template_id = template_id3
        token_management.configuration_information = configuration_information7
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

        Merchant_boarding_tsys.new.run()
    end
end
