require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Validate_authentication_results
    def run()
        request_obj = CyberSource::ValidateRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "pavalidatecheck"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "7891234"
        partner.solution_id = "89012345"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1authenticationresultsOrderInformation.new
        amount_details = CyberSource::Riskv1authenticationresultsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "200.00"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        payment_information = CyberSource::Riskv1authenticationresultsPaymentInformation.new
        card = CyberSource::Riskv1authenticationresultsPaymentInformationCard.new
        card.type = "002"
        card.expiration_month = "12"
        card.expiration_year = "2025"
        card.number = "5200000000000007"
        payment_information.card = card
        request_obj.payment_information = payment_information

        consumer_authentication_information = CyberSource::Riskv1authenticationresultsConsumerAuthenticationInformation.new
        consumer_authentication_information.authentication_transaction_id = "PYffv9G3sa1e0CQr5fV0"
        request_obj.consumer_authentication_information = consumer_authentication_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.validate_authentication_results(request_obj)

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
        Validate_authentication_results.new.run()
    end
end
