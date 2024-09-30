require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_vpc
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
        common.master_card_assigned_id = nil
        common.sic_code = nil
        common.enable_partial_auth = false

        common.enable_interchange_optimization = false
        common.enable_split_shipment = false
        common.visa_delegated_authentication_id = "123457"

        common.domestic_merchant_id = "123458"
        common.credit_card_refund_limit_percent = "2"
        common.business_center_credit_card_refund_limit_percent = "3"
        common.allow_captures_greater_than_authorizations = false
        common.enable_duplicate_merchant_reference_number_blocking = false

        processors = {}
        obj5 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new

        acquirer.country_code = "840_usa"
        acquirer.file_destination_bin = "444500"
        acquirer.interbank_card_association_id = "3684"
        acquirer.institution_id = "444571"
        acquirer.discover_institution_id = nil

        obj5.acquirer = acquirer

        payment_types = {}
        obj7 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj7.enabled = true

        currencies = {}
        obj2 = CyberSource::CardProcessingConfigCommonCurrencies.new
        obj2.enabled = true
        obj2.enabled_card_present = false
        obj2.enabled_card_not_present = true
        obj2.terminal_id = "113366"
        obj2.merchant_id = "113355"
        obj2.service_enablement_number = nil

        currencies["CAD"] = obj2
        currencies["USD"] = obj2

        obj7.currencies = currencies

        payment_types["VISA"] = obj7

        obj5.payment_types = payment_types

        obj5.acquirer_merchant_id = "123456"
        obj5.allow_multiple_bills = false
        obj5.batch_group = "vdcvantiv_est_00"
        obj5.business_application_id = "AA"
        obj5.enable_auto_auth_reversal_after_void = true
        obj5.enable_expresspay_pan_translation = nil
        obj5.merchant_verification_value = "123456"
        obj5.quasi_cash = false
        obj5.enable_transaction_reference_number = true

        processors["VPC"] = obj5

        common.processors = processors

        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new

        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new

        processors3 = {}
        obj9 = CyberSource::CardProcessingConfigFeaturesCardNotPresentProcessors.new

        obj9.enable_ems_transaction_risk_score = nil
        obj9.relax_address_verification_system = true
        obj9.relax_address_verification_system_allow_expired_card = true
        obj9.relax_address_verification_system_allow_zip_without_country = true

        processors3["VPC"] = obj9
        card_not_present.processors = processors3

        card_not_present.visa_straight_through_processing_only = false
        card_not_present.ignore_address_verification_system = true

        features2.card_not_present = card_not_present

        card_present = CyberSource::CardProcessingConfigFeaturesCardPresent.new

        processors2 = {}
        obj4 = CyberSource::CardProcessingConfigFeaturesCardPresentProcessors.new

        obj4.default_point_of_sale_terminal_id = "223355"
        obj4.default_point_of_sale_terminal_id = "223344"

        processors2["VPC"] = obj4

        card_present.processors = processors2

        card_present.enable_terminal_id_lookup = false
        features2.card_present = card_present

        configurations.features = features2
        configuration_information.configurations = configurations

        template_id = "D671CE88-2F09-469C-A1B4-52C47812F792"
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

        Merchant_boarding_vpc.new.run()
    end
end
