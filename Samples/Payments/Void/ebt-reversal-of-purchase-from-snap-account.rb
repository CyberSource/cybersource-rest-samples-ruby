require 'cybersource_rest_client'
require_relative '../Credit/ebt-merchandise-return-credit-voucher-from-snap.rb'
require_relative '../../../data/Configuration.rb'

public
class Ebt_reversal_of_purchase_from_snap_account
    def run()
        id = (JSON.parse(Ebt_merchandise_return_credit_voucher_from_snap.new.run()[0]))['id']
        request_obj = CyberSource::VoidPaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidreversalsClientReferenceInformation.new
        client_reference_information.code = "Reversal of Purchase from SNAP Account"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Ptsv2paymentsidvoidsPaymentInformation.new
        payment_type = CyberSource::Ptsv2paymentsidrefundsPaymentInformationPaymentType.new
        payment_type.name = "CARD"
        payment_type.sub_type_name = "DEBIT"
        payment_information.payment_type = payment_type
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidvoidsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidreversalsReversalInformationAmountDetails.new
        amount_details.total_amount = "204.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VoidApi.new(api_client, config)

        data, status_code, headers = api_instance.void_payment(request_obj, id)

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
        Ebt_reversal_of_purchase_from_snap_account.new.run()
    end
end