require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Credit_using_bluefin_pci_p2pe_for_card_present_enabled_acquirer
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "demomerchant"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2creditsProcessingInformation.new
        processing_information.commerce_indicator = "retail"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsidrefundsPaymentInformationCard.new
        card.expiration_month = "12"
        card.expiration_year = "2050"
        payment_information.card = card
        fluid_data = CyberSource::Ptsv2paymentsPaymentInformationFluidData.new
        fluid_data.descriptor = "Ymx1ZWZpbg=="
        fluid_data.value = "02d700801f3c20008383252a363031312a2a2a2a2a2a2a2a303030395e46444d53202020202020202020202020202020202020202020205e323231322a2a2a2a2a2a2a2a3f2a3b363031312a2a2a2a2a2a2a2a303030393d323231322a2a2a2a2a2a2a2a3f2a7a75ad15d25217290c54b3d9d1c3868602136c68d339d52d98423391f3e631511d548fff08b414feac9ff6c6dede8fb09bae870e4e32f6f462d6a75fa0a178c3bd18d0d3ade21bc7a0ea687a2eef64551751e502d97cb98dc53ea55162cdfa395431323439323830303762994901000001a000731a8003"
        payment_information.fluid_data = fluid_data
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "100.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsidcapturesOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Deo"
        bill_to.address1 = "201 S. Division St."
        bill_to.locality = "Ann Arbor"
        bill_to.administrative_area = "MI"
        bill_to.postal_code = "48104-2201"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "999999999"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.cat_level = 1
        point_of_sale_information.entry_mode = "keyed"
        point_of_sale_information.terminal_capability = 2
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

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

        Credit_using_bluefin_pci_p2pe_for_card_present_enabled_acquirer.new.run()
    end
end
