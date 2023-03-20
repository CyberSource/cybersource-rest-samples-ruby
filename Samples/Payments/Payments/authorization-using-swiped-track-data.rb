require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Authorization_using_swiped_track_data
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "ABC123"
        partner = CyberSource::Ptsv2paymentsClientReferenceInformationPartner.new
        partner.third_party_certification_number = "123456789012"
        client_reference_information.partner = partner
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
        point_of_sale_information.entry_mode = "swiped"
        point_of_sale_information.terminal_capability = 2
        point_of_sale_information.track_data = "%B38000000000006^TEST/CYBS         ^2012121019761100      00868000000?"
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

        Authorization_using_swiped_track_data.new.run()
    end
end
