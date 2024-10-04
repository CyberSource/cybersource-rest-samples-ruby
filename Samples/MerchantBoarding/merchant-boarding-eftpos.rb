require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_eftpos
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
        obj1.enabled = false
        features["cardPresent"] = obj1
        subscription_information.features = features
        card_processing.subscription_information = subscription_information

        configuration_information = CyberSource::PaymentsProductsCardProcessingConfigurationInformation.new

        configurations = CyberSource::CardProcessingConfig.new
        common = CyberSource::CardProcessingConfigCommon.new
        common.merchant_category_code = "5999"
        common.prefer_cobadged_secondary_brand = true

        processors = {}
        obj5 = CyberSource::CardProcessingConfigCommonProcessors.new
        acquirer = CyberSource::CardProcessingConfigCommonAcquirer.new
        acquirer.country_code = "344_hongkong"
        acquirer.institution_id = "22344"

        obj5.acquirer = acquirer

        currencies = {}
        obj6 = CyberSource::CardProcessingConfigCommonCurrencies1.new
        obj6.enabled = true
        obj6.merchant_id = "12345612344"
        obj6.terminal_id = "12121212"
        currencies["AUD"] = obj6
        obj5.currencies = currencies

        payment_types = {}
        obj7 = CyberSource::CardProcessingConfigCommonPaymentTypes.new
        obj7.enabled = true
        payment_types["EFTPOS"] = obj7

        obj5.payment_types = payment_types

        obj5.enable_cvv_response_indicator = true
        obj5.enable_least_cost_routing = true
        obj5.merchant_tier = "000"

        processors["EFTPOS"] = obj5

        common.processors = processors
        configurations.common = common

        features2 = CyberSource::CardProcessingConfigFeatures.new

        configurations.features = features2
        configuration_information.configurations = configurations
        template_id = "1F9B7F6E-F0DB-44C8-BF8E-5013E34C0F87"
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

        Merchant_boarding_eftpos.new.run()
    end
end
