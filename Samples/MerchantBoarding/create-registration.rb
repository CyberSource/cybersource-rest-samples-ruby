require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Create_registration
    def run()
       
        # Create the request object
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

        # Setup Product Information
        product_information = CyberSource::Boardingv1registrationsProductInformation.new
        selected_products = CyberSource::Boardingv1registrationsProductInformationSelectedProducts.new
        payments = CyberSource::PaymentsProducts.new

        # Setup Payments Products
        payer_authentication = CyberSource::PaymentsProductsPayerAuthentication.new
        subscription_information = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information.enabled = true
        payer_authentication.subscription_information = subscription_information

        configuration_information = CyberSource::PaymentsProductsPayerAuthenticationConfigurationInformation.new
        configurations = CyberSource::PayerAuthConfig.new
        card_types = CyberSource::PayerAuthConfigCardTypes.new
        verified_by_visa = CyberSource::PayerAuthConfigCardTypesVerifiedByVisa.new
        currencies = []
        currency1 = CyberSource::PayerAuthConfigCardTypesVerifiedByVisaCurrencies.new
        currency1.currency_codes = ["ALL"]
        currency1.acquirer_id = "469216"
        currency1.processor_merchant_id = "678855"

        currencies << currency1
        verified_by_visa.currencies = currencies
        card_types.verified_by_visa = verified_by_visa
        configurations.card_types = card_types
        configuration_information.configurations = configurations
        payer_authentication.configuration_information = configuration_information
        payments.payer_authentication = payer_authentication

        # Setup Card Processing
        card_processing = CyberSource::PaymentsProductsCardProcessing.new
        subscription_information2 = CyberSource::PaymentsProductsCardProcessingSubscriptionInformation.new
        subscription_information2.enabled = true
        features = {}
        features['cardNotPresent'] = CyberSource::PaymentsProductsCardProcessingSubscriptionInformationFeatures.new(enabled: true)
        subscription_information2.features = features
        card_processing.subscription_information = subscription_information2

        configuration_information2 = CyberSource::PaymentsProductsCardProcessingConfigurationInformation.new
        configurations2 = CyberSource::CardProcessingConfig.new
        common = CyberSource::CardProcessingConfigCommon.new
        common.merchant_category_code = "1234"

        merchant_descriptor_information = CyberSource::CardProcessingConfigCommonMerchantDescriptorInformation.new
        merchant_descriptor_information.name = "r4ef"
        merchant_descriptor_information.city = "Bellevue"
        merchant_descriptor_information.country = "US"
        merchant_descriptor_information.phone = "4255547845"
        merchant_descriptor_information.state = "WA"
        merchant_descriptor_information.street = "StreetName"
        merchant_descriptor_information.zip = "98007"
        common.merchant_descriptor_information = merchant_descriptor_information

        processors = {}
        processors['tsys'] = CyberSource::CardProcessingConfigCommonProcessors.new(
        merchant_id: "123456789101",
        terminal_id: "1231",
        industry_code: "D",
        vital_number: "71234567",
        merchant_bin_number: "123456",
        merchant_location_number: "00001",
        store_id: "1234",
        settlement_currency: "USD"
        )
        common.processors = processors
        configurations2.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new
        card_not_present = CyberSource::CardProcessingConfigFeaturesCardNotPresent.new
        card_not_present.visa_straight_through_processing_only = true
        features2.card_not_present = card_not_present
        configurations2.features = features2
        configuration_information2.configurations = configurations2
        card_processing.configuration_information = configuration_information2
        payments.card_processing = card_processing

        # Setup other payment-related products
        virtual_terminal = CyberSource::PaymentsProductsVirtualTerminal.new
        subscription_information3 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information3.enabled = true
        virtual_terminal.subscription_information = subscription_information3
        payments.virtual_terminal = virtual_terminal

        customer_invoicing = CyberSource::PaymentsProductsTax.new
        subscription_information4 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information4.enabled = true
        customer_invoicing.subscription_information = subscription_information4
        payments.customer_invoicing = customer_invoicing

        payouts = CyberSource::PaymentsProductsPayouts.new
        subscription_information5 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information5.enabled = true
        payouts.subscription_information = subscription_information5
        payments.payouts = payouts

        selected_products.payments = payments

        # Setup Commerce Solutions
        commerce_solutions = CyberSource::CommerceSolutionsProducts.new
        token_management = CyberSource::CommerceSolutionsProductsTokenManagement.new
        subscription_information6 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information6.enabled = true
        token_management.subscription_information = subscription_information6
        commerce_solutions.token_management = token_management
        selected_products.commerce_solutions = commerce_solutions

        # Setup Risk Products
        risk = CyberSource::RiskProducts.new
        fraud_management_essentials = CyberSource::RiskProductsFraudManagementEssentials.new
        subscription_information7 = CyberSource::PaymentsProductsPayerAuthenticationSubscriptionInformation.new
        subscription_information7.enabled = true
        fraud_management_essentials.subscription_information = subscription_information7

        configuration_information5 = CyberSource::RiskProductsFraudManagementEssentialsConfigurationInformation.new
        template_id = 'E4EDB280-9DAC-4698-9EB9-9434D40FF60C'
        configuration_information5.template_id = template_id
        fraud_management_essentials.configuration_information = configuration_information5
        risk.fraud_management_essentials = fraud_management_essentials

        selected_products.risk = risk

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

        Create_registration.new.run()
    end
end
