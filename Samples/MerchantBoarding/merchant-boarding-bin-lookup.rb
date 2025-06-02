require 'cybersource_rest_client'
require_relative '../../data/MerchantBoardingConfiguration.rb'

public
class Merchant_boarding_bin_lookup
    def run()
       
        # Initialize the main request object
        req_obj = CyberSource::PostRegistrationBody.new

        # Set up organization information
        organization_information = CyberSource::Boardingv1registrationsOrganizationInformation.new
        organization_information.parent_organization_id = "apitester00"
        organization_information.type = "MERCHANT"
        organization_information.configurable = true

        # Set up business information
        business_information = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformation.new
        business_information.name = "StuartWickedFastEatz"

        # Set up business address
        address = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformationAddress.new
        address.country = "US"
        address.address1 = "123456 SandMarket"
        address.locality = "ORMOND BEACH"
        address.administrative_area = "FL"
        address.postal_code = "32176"
        business_information.address = address

        # Additional business information
        business_information.website_url = "https://www.StuartWickedEats.com"
        business_information.phone_number = "6574567813"

        # Set up business contact
        business_contact = CyberSource::Boardingv1registrationsOrganizationInformationBusinessInformationBusinessContact.new
        business_contact.first_name = "Stuart"
        business_contact.last_name = "Stuart"
        business_contact.phone_number = "6574567813"
        business_contact.email = "svc_email_bt@corpdev.visa.com"
        business_information.business_contact = business_contact
        business_information.merchant_category_code = "5999"
        organization_information.business_information = business_information

        # Assign organization information to the request
        req_obj.organization_information = organization_information

        # Set up product information
        product_information = CyberSource::Boardingv1registrationsProductInformation.new
        selected_products = CyberSource::Boardingv1registrationsProductInformationSelectedProducts.new

        # Payments products
        payments = CyberSource::PaymentsProducts.new
        selected_products.payments = payments

        # Risk products
        risk = CyberSource::RiskProducts.new
        selected_products.risk = risk

        # Commerce solutions products
        commerce_solutions = CyberSource::CommerceSolutionsProducts.new
        bin_lookup = CyberSource::CommerceSolutionsProductsBinLookup.new


        # Configuration information
        configuration_information = CyberSource::CommerceSolutionsProductsBinLookupConfigurationInformation.new
        configurations = CyberSource::CommerceSolutionsProductsBinLookupConfigurationInformationConfigurations.new
        configurations.is_payout_options_enabled = false
        configurations.is_account_prefix_enabled = true
        configuration_information.configurations = configurations
        bin_lookup.configuration_information = configuration_information

        commerce_solutions.bin_lookup = bin_lookup
        selected_products.commerce_solutions = commerce_solutions

        # Value-added services products
        value_added_services = CyberSource::ValueAddedServicesProducts.new
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

        Merchant_boarding_bin_lookup.new.run()
    end
end
