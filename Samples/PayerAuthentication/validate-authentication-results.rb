require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Validate_authentication_results
    def run()
        request_obj = CyberSource::ValidateRequest.new
        client_reference_information = CyberSource::Riskv1authenticationsClientReferenceInformation.new
        client_reference_information.code = "pavalidatecheck"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1authenticationresultsOrderInformation.new
        amount_details = CyberSource::Riskv1decisionsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "200.00"
        order_information.amount_details = amount_details

        line_items = []
        line_items1 = CyberSource::Riskv1authenticationresultsOrderInformationLineItems.new
        line_items1.unit_price = "10"
        line_items1.quantity = 2
        line_items1.tax_amount = "32.40"
        line_items << line_items1

        order_information.line_items = line_items
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
        consumer_authentication_information.signed_pares = "eNqdmFmT4jgSgN+J4D90zD4yMz45PEFVhHzgA2zwjXnzhQ984Nvw61dAV1"
        request_obj.consumer_authentication_information = consumer_authentication_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.validate_authentication_results(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Validate_authentication_results.new.run()
    end
end
