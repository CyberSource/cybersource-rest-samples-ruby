require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Pin_debit_credit_using_emv_technology_with_contactless_read_with_visa_platform_connect
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "2.2 Credit"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2creditsProcessingInformation.new
        processing_information.commerce_indicator = "retail"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        payment_type = CyberSource::Ptsv2paymentsidrefundsPaymentInformationPaymentType.new
        payment_type.name = "CARD"
        payment_type.sub_type_name = "DEBIT"
        payment_information.payment_type = payment_type
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "202.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsidrefundsMerchantInformation.new
        request_obj.merchant_information = merchant_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.entry_mode = "contactless"
        point_of_sale_information.terminal_capability = 4
        emv = CyberSource::Ptsv2paymentsPointOfSaleInformationEmv.new
        emv.tags = "9F3303204000950500000000009F3704518823719F100706011103A000009F26081E1756ED0E2134E29F36020015820200009C01009F1A0208409A030006219F02060000000020005F2A0208409F0306000000000000"
        emv.card_sequence_number = "1"
        emv.fallback = false
        point_of_sale_information.emv = emv
        point_of_sale_information.track_data = "%B4111111111111111^JONES/JONES ^3112101976110000868000000?;4111111111111111=16121019761186800000?"
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

        puts status_code, headers, data
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

        Pin_debit_credit_using_emv_technology_with_contactless_read_with_visa_platform_connect.new.run()
    end
end
