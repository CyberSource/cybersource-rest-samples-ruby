require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Authorization_with_tms_token_bypassing_network_token
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        instrument_identifier = CyberSource::Ptsv2paymentsPaymentInformationInstrumentIdentifier.new
        instrument_identifier.id = "7010000000016241111"
        payment_information.instrument_identifier = instrument_identifier
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "102.21"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        token_information = CyberSource::Ptsv2paymentsTokenInformation.new
        token_information.network_token_option = "ignore"
        request_obj.token_information = token_information

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

        Authorization_with_tms_token_bypassing_network_token.new.run()
    end
end
