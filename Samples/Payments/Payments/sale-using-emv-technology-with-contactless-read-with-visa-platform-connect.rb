require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Sale_using_emv_technology_with_contactless_read_with_visa_platform_connect
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "123456"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.commerce_indicator = "retail"
        authorization_options = CyberSource::Ptsv2paymentsProcessingInformationAuthorizationOptions.new
        authorization_options.partial_auth_indicator = true
        authorization_options.ignore_avs_result = false
        authorization_options.ignore_cv_result = false
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.cat_level = 2
        point_of_sale_information.entry_mode = "contactless"
        point_of_sale_information.terminal_capability = 5
        emv = CyberSource::Ptsv2paymentsPointOfSaleInformationEmv.new
        emv.tags = "9F3303204000950500000000009F3704518823719F100706011103A000009F26081E1756ED0E2134E29F36020015820200009C01009F1A0208409A030006219F02060000000020005F2A0208409F0306000000000000"
        emv.card_sequence_number = "1"
        emv.fallback = false
        point_of_sale_information.emv = emv
        point_of_sale_information.track_data = "%B38000000000006^TEST/CYBS         ^2012121019761100      00868000000?;38000000000006=20121210197611868000?"
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

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

        Sale_using_emv_technology_with_contactless_read_with_visa_platform_connect.new.run()
    end
end
