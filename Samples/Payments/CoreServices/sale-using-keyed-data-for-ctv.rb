require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Sale_using_keyed_data_for_ctv
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "123456"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = true
        processing_information.commerce_indicator = "retail"
        authorization_options = CyberSource::Ptsv2paymentsProcessingInformationAuthorizationOptions.new
        authorization_options.partial_auth_indicator = true
        authorization_options.ignore_avs_result = true
        authorization_options.ignore_cv_result = true
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.security_code = "123"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.entry_mode = "keyed"
        point_of_sale_information.terminal_capability = 2
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts status_code, headers, data
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Sale_using_keyed_data_for_ctv.new.run()
    end
end
