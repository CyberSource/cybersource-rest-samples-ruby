require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_gpx
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
        common.default_auth_type_code = "FINAL"
        common.food_and_consumer_service_id = "1456"
        common.master_card_assigned_id = "4567"
        common.sic_code = "1345"
        common.enable_partial_auth = false
        common.allow_captures_greater_than_authorizations = false
        common.enable_duplicate_merchant_reference_number_blocking = false
        common.credit_card_refund_limit_percent = "2"
        common.business_center_credit_card_refund_limit_percent = "3"

        processors = {}
        obj5 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new

        acquirer.country_code = "840_usa"
        acquirer.file_destination_bin = "123456"
        acquirer.interbank_card_association_id = "1256"
        acquirer.institution_id = "113366"
        acquirer.discover_institution_id = "1567"

        obj5.acquirer = acquirer

        currencies = {}
        obj6 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj6.enabled = true
        obj6.enabled_card_present = false
        obj6.enabled_card_not_present = true
        obj6.terminal_id = ""
        obj6.service_enablement_number = ""

        currencies["AED"] = obj6

        obj5.currencies = currencies

        payment_types = {}
        obj7 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj7.enabled = true

        payment_types["MASTERCARD"] = obj7
        payment_types["DISCOVER"] = obj7
        payment_types["JCB"] = obj7
        payment_types["VISA"] = obj7
        payment_types["DINERS_CLUB"] = obj7
        payment_types["PIN_DEBIT"] = obj7

        obj5.payment_types = payment_types

        obj5.allow_multiple_bills = true
        obj5.batch_group = "gpx"
        obj5.business_application_id = "AA"
        obj5.enhanced_data = "disabled"
        obj5.fire_safety_indicator = false
        obj5.aba_number = "1122445566778"
        obj5.merchant_verification_value = "234"
        obj5.quasi_cash = false
        obj5.merchant_id = "112233"
        obj5.terminal_id = "112244"

        processors["gpx"] = obj5

        common.processors = processors

        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new

        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new

        processors3 = {}
        obj9 = CyberSource::CardProcessingConfigFeaturesCardNotPresentProcessors.new

        obj9.enable_ems_transaction_risk_score = true
        obj9.relax_address_verification_system = true
        obj9.relax_address_verification_system_allow_expired_card = true
        obj9.relax_address_verification_system_allow_zip_without_country = true

        processors3["gpx"] = obj9
        card_not_present.processors = processors3

        card_not_present.visa_straight_through_processing_only = false
        card_not_present.ignore_address_verification_system = false

        features2.card_not_present = card_not_present

        card_present = CyberSource::CardProcessingConfigFeaturesCardPresent.new

        processors2 = {}
        obj4 = CyberSource::CardProcessingConfigFeaturesCardPresentProcessors.new

        obj4.financial_institution_id = "1347"
        obj4.pin_debit_network_order = "23456"
        obj4.pin_debit_reimbursement_code = "43567"
        obj4.default_point_of_sale_terminal_id = "5432"

        processors2["gpx"] = obj4

        card_present.processors = processors2

        card_present.enable_terminal_id_lookup = false
        features2.card_present = card_present

        configurations.features = features2
        configuration_information.configurations = configurations
        template_id = "D2A7C000-5FCA-493A-AD21-469744A19EEA"
        configuration_information.template_id = template_id

        card_processing.configuration_information = configuration_information
        payments.card_processing = card_processing

        virtual_terminal = CyberSource::PaymentsProductsVirtualTerminal.new
        subscription_information5 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information5.enabled = true
        virtual_terminal.subscription_information = subscription_information5

        configuration_information5 = CyberSource::PaymentsProductsVirtualTerminalConfigurationInformation.new
        template_id2 = "9FA1BB94-5119-48D3-B2E5-A81FD3C657B5"
        configuration_information5.template_id = template_id2
        virtual_terminal.configuration_information = configuration_information5

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

        configuration_information7 = CyberSource::CommerceSolutionsProductsTokenManagementConfigurationInformation.new

        template_id3 = "D62BEE20-DCFD-4AA2-8723-BA3725958ABA"
        configuration_information7.template_id = template_id3
        token_management.configuration_information = configuration_information7

        commerce_solutions.token_management = token_management
        selected_products.commerce_solutions = commerce_solutions

        value_added_services = CyberSource::ValueAddedServicesProducts.new

        transaction_search = CyberSource::PaymentsProductsTax.new

        subscription_information9 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information9.enabled = true
        transaction_search.subscription_information = subscription_information9
        value_added_services.transaction_search = transaction_search

        reporting = CyberSource::PaymentsProductsTax.new
        subscription_information3 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information3.enabled = true
        reporting.subscription_information = subscription_information3
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

        Merchant_boarding_gpx.new.run()
    end
end
