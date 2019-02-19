require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call Payout - DefaultApi,
# * Process a Payout
# * OctCreatePaymentRequest method will create a new payout

public
class ProcessPayout
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::PtsV2PayoutsPostResponse.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::ProcessAPayoutApi.new(api_client, config)

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "33557799"
    request.client_reference_information = client_reference_information

    sender_information = CyberSource::Ptsv2payoutsSenderInformation.new
    sender_information.reference_number = "1234567890"
    sender_information.address1 = "900 Metro Center Blvd.900"
    sender_information.country_code = "US"
    sender_information.locality = "Foster City"
    sender_information.name = "Thomas Jefferson"
    sender_information.administrative_area = "CA"
    account = CyberSource::Ptsv2payoutsSenderInformationAccount.new
    account.number = "1234567890123456789012345678901234"
    account.funds_source = "01"
    sender_information.account = account
    request.sender_information = sender_information

    processing_information = CyberSource::Ptsv2payoutsProcessingInformation.new
    processing_information.commerce_indicator = "internet"
    processing_information.business_application_id = "FD"
    processing_information.network_routing_order = "ECG"
    request.processing_information = processing_information

    payout_options = CyberSource::Ptsv2payoutsProcessingInformationPayoutsOptions.new
    payout_options.retrieval_reference_number = "123456789012"
    payout_options.acquirer_bin = "567890124"

    # missing
    # processing_information.reconciliation_id = "1087488702VIAQNSPQ"

    order_information = CyberSource::Ptsv2payoutsOrderInformation.new
    amount_details = CyberSource::Ptsv2payoutsOrderInformationAmountDetails.new
    amount_details.total_amount = "100.00"
    amount_details.currency = "USD"
    order_information.amount_details = amount_details
    request.order_information = order_information

    merchant_information = CyberSource::Ptsv2payoutsMerchantInformation.new
    merchant_information.category_code = 123
    merchant_descriptor = CyberSource::Ptsv2payoutsMerchantInformationMerchantDescriptor.new
    merchant_descriptor.country = "US"
    merchant_descriptor.postal_code = "94440"
    merchant_descriptor.locality = "FC"
    merchant_descriptor.name = "Thomas"
    merchant_descriptor.administrative_area = "CA"
    merchant_information.merchant_descriptor = merchant_descriptor
    request.merchant_information = merchant_information

    payment_information = CyberSource::Ptsv2payoutsPaymentInformation.new
    payment_information_card = CyberSource::Ptsv2payoutsPaymentInformationCard.new
    payment_information_card.expiration_year = "2025"
    payment_information_card.number = "4111111111111111"
    payment_information_card.expiration_month = "12"
    payment_information_card.type = "001"
    payment_information_card.source_account_type = "CH"
    payment_information.card = payment_information_card
    request.payment_information = payment_information

    recipient_information = CyberSource::Ptsv2payoutsRecipientInformation.new
    recipient_information.first_name = "John"
    recipient_information.last_name = "Doe"
    recipient_information.address1 = "Paseo Padre Boulevard"
    recipient_information.locality = "Foster City"
    recipient_information.administrative_area = "CA"
    recipient_information.postal_code = "94400"
    recipient_information.phone_number = "6504320556"
    recipient_information.date_of_birth = "19801009"
    recipient_information.country = "US"
    request.recipient_information = recipient_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.oct_create_payment(request)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
  rescue StandardError => err
    if (err.respond_to? :response_headers) || (err.respond_to? :response_body) || (err.respond_to? :code)
      puts "\nAPI REQUEST HEADERS:"
      puts api_client.request_headers
      puts "\nAPI RESPONSE CODE: \n#{err.code}", "\nAPI RESPONSE HEADERS: \n#{err.response_headers}", "\nAPI RESPONSE BODY: \n#{err.response_body}"
    else
      puts err.message
    end
  ensure
    puts "\n[END] REQUEST & RESPONSE OF: #{self.class.name}"
  end
  ProcessPayout.new.main
end