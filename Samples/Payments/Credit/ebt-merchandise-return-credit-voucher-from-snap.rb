require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Ebt_merchandise_return_credit_voucher_from_snap
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "Merchandise Return / Credit Voucher from SNAP"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2creditsProcessingInformation.new
        processing_information.commerce_indicator = "retail"
        purchase_options = CyberSource::Ptsv2creditsProcessingInformationPurchaseOptions.new
        purchase_options.is_electronic_benefits_transfer = true
        processing_information.purchase_options = purchase_options
        electronic_benefits_transfer = CyberSource::Ptsv2creditsProcessingInformationElectronicBenefitsTransfer.new
        electronic_benefits_transfer.category = "FOOD"
        processing_information.electronic_benefits_transfer = electronic_benefits_transfer
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsidrefundsPaymentInformationCard.new
        card.type = "001"
        payment_information.card = card
        payment_type = CyberSource::Ptsv2paymentsidrefundsPaymentInformationPaymentType.new
        payment_type.name = "CARD"
        payment_type.sub_type_name = "DEBIT"
        payment_information.payment_type = payment_type
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "204.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsidrefundsMerchantInformation.new
        merchant_information.category_code = 5411
        request_obj.merchant_information = merchant_information

        point_of_sale_information = CyberSource::Ptsv2paymentsPointOfSaleInformation.new
        point_of_sale_information.entry_mode = "swiped"
        point_of_sale_information.terminal_capability = 4
        point_of_sale_information.track_data = "%B4111111111111111^JONES/JONES ^3112101976110000868000000?;4111111111111111=16121019761186800000?"
        point_of_sale_information.pin_block_encoding_format = 1
        point_of_sale_information.encrypted_pin = "52F20658C04DB351"
        point_of_sale_information.encrypted_key_serial_number = "FFFF1B1D140000000005"
        request_obj.point_of_sale_information = point_of_sale_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

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
        Ebt_merchandise_return_credit_voucher_from_snap.new.run()
    end
end