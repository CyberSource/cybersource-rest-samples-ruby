require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Setup_completion_with_card_number
    def run()
        request_obj = CyberSource::PayerAuthSetupRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "cybs_test"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "7891234"
        partner.solution_id = "89012345"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Riskv1authenticationsetupsPaymentInformation.new
        card = CyberSource::Riskv1authenticationsetupsPaymentInformationCard.new
        card.type = "001"
        card.expiration_month = "12"
        card.expiration_year = "2025"
        card.number = "4000000000000101"
        payment_information.card = card
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayerAuthenticationApi.new(api_client, config)

        data, status_code, headers = api_instance.payer_auth_setup(request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Setup_completion_with_card_number.new.run()
    end
end
