require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Ebt_electronic_voucher_purchase_from_snap_account_with_visa_platform_connect
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "EBT - Voucher Purchase From SNAP Account"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.commerce_indicator = "retail"
        purchase_options = CyberSource::Ptsv2paymentsProcessingInformationPurchaseOptions.new
        purchase_options.is_electronic_benefits_transfer = true
        processing_information.purchase_options = purchase_options
        electronic_benefits_transfer = CyberSource::Ptsv2paymentsProcessingInformationElectronicBenefitsTransfer.new
        electronic_benefits_transfer.category = "FOOD"
        electronic_benefits_transfer.voucher_serial_number = "123451234512345"
        processing_information.electronic_benefits_transfer = electronic_benefits_transfer
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4012002000013007"
        card.expiration_month = "12"
        card.expiration_year = "25"
        payment_information.card = card
        payment_type = CyberSource::Ptsv2paymentsPaymentInformationPaymentType.new
        payment_type.name = "CARD"
        payment_type.sub_type_name = "DEBIT"
        payment_information.payment_type = payment_type
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "103.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.entry_mode = "keyed"
        point_of_sale_information.terminal_capability = 4
        point_of_sale_information.track_data = "%B4111111111111111^JONES/JONES ^3112101976110000868000000?;4111111111111111=16121019761186800000?"
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts status_code, headers, data

        write_log_audit(status_code)
        return data, status_code, headers
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Ebt_electronic_voucher_purchase_from_snap_account_with_visa_platform_connect.new.run()
    end
end