require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class sale_using_emv_technology_with_contact_read_one_for_acquirer
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "123456"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.commerce_indicator = "retail"
        request_obj.processing_information = processing_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.cat_level = 1
        point_of_sale_information.entry_mode = "contact"
        point_of_sale_information.terminal_capability = 1
        emv = CyberSource::Ptsv2paymentsPointOfSaleInformationEmv.new
        emv.card_sequence_number = "0"
        emv.fallback = false
        point_of_sale_information.emv = emv
        point_of_sale_information.track_data = "%B4111111111111111^TEST/CYBS         ^2012121019761100      00868000000?;"
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        sale_using_emv_technology_with_contact_read_one_for_acquirer.new.run()
    end
end
