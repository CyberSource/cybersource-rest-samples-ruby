require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class authentication-exemption
    def run()
        request_obj = CyberSource::AuthenticationExemptionsRequest.new
        client_reference_information = CyberSource::PtsV2IncrementalAuthorizationPatch201ResponseClientReferenceInformation.new
        client_reference_information.code = "1"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1authenticationexemptionsOrderInformation.new
        amount_details = CyberSource::Riskv1decisionsOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.total_amount = "12.10"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Riskv1authenticationexemptionsOrderInformationBillTo.new
        bill_to.address1 = "1 Market St"
        bill_to.administrative_area = "CA"
        bill_to.country = "US"
        bill_to.locality = "San Francisco"
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.phone_number = "4158880000"
        bill_to.email = "test@cybs.com"
        bill_to.postal_code = "94105"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        payment_information = CyberSource::Riskv1authenticationexemptionsPaymentInformation.new
        card = CyberSource::Riskv1authenticationexemptionsPaymentInformationCard.new
        card.type = "054"
        card.expiration_month = "12"
        card.expiration_year = "2020"
        card.number = "4843411477501698"
        payment_information.card = card
        request_obj.payment_information = payment_information

        device_information = CyberSource::Riskv1authenticationexemptionsDeviceInformation.new
        device_information.fingerprint_session_id = "910523731556650421"
        request_obj.device_information = device_information

        merchant_information = CyberSource::Riskv1authenticationexemptionsMerchantInformation.new
        merchant_information.visa_merchant_id = "909090"
        merchant_information.card_acceptor_id = "123456712345612"
        merchant_information.merchant_category_code = "4567"
        merchant_descriptor = CyberSource::Riskv1authenticationexemptionsMerchantInformationMerchantDescriptor.new
        merchant_descriptor.name = "123"
        merchant_descriptor.locality = "San Francisco"
        merchant_descriptor.administrative_area = "CA"
        merchant_descriptor.country = "US"
        merchant_information.merchant_descriptor = merchant_descriptor
        request_obj.merchant_information = merchant_information

        acquirer_information = CyberSource::Riskv1authenticationexemptionsAcquirerInformation.new
        acquirer_information.acquirer_bin = "234523"
        request_obj.acquirer_information = acquirer_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::AuthenticationExemptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.authentication_exemptions(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        authentication-exemption.new.run()
    end
end
