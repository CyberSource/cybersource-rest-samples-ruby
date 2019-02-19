require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call PaymentApi,
# * for Core Services - Process Payment
# * createPayment method will create a new payment

public
class ProcessPayment
  def main(capture_flag)
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::CreatePaymentRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PaymentsApi.new(api_client, config)
    
    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_payment"
    request.client_reference_information = client_reference_information
    processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
    processing_information.commerce_indicator = "internet"
    if capture_flag
      processing_information.capture = true
    end
    request.processing_information = processing_information
    aggregator_information = CyberSource::Ptsv2paymentsAggregatorInformation.new
    sub_merchant_information = CyberSource::Ptsv2paymentsAggregatorInformationSubMerchant.new
    sub_merchant_information.card_acceptor_id = "1234567890"
    sub_merchant_information.country = "US"
    sub_merchant_information.phone_number = "4158880000"
    sub_merchant_information.address1 = "1 Market St"
    sub_merchant_information.postal_code = "94105"
    sub_merchant_information.locality = "san francisco"
    sub_merchant_information.name = "Visa Inc"
    sub_merchant_information.administrative_area = "CA"
    sub_merchant_information.region = "PEN"
    sub_merchant_information.email = "test@cybs.com"
    aggregator_information.sub_merchant = sub_merchant_information
    aggregator_information.name = "V-Internatio"
    aggregator_information.aggregator_id = "123456789"
    request.aggregator_information = aggregator_information
    
    order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    bill_to_information = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
    bill_to_information.country = "US"
    bill_to_information.last_name = "Deo"
    bill_to_information.address2 = "Address 2"
    bill_to_information.address1 = "1 Market St"
    bill_to_information.postal_code = "94105"
    bill_to_information.locality = "san francisco"
    bill_to_information.administrative_area = "CA"
    bill_to_information.first_name = "John"
    bill_to_information.phone_number = "4158880000"
    bill_to_information.district = "MI"
    bill_to_information.building_number = "123"
    bill_to_information.company = "Visa"
    bill_to_information.email = "test@cybs.com"
    order_information.bill_to = bill_to_information
    request.order_information = order_information

    amount_information = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_information.total_amount = "102.21"
    amount_information.currency = "USD"
    order_information.amount_details = amount_information
    request.order_information = order_information

    payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
    card_information =CyberSource::Ptsv2paymentsPaymentInformationCard.new
    card_information.expiration_year = "2031"
    card_information.number = "5555555555554444"
    card_information.security_code = "123"
    card_information.expiration_month = "12"
    card_information.type = "002"
    payment_information.card = card_information
    request.payment_information = payment_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.create_payment(request)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
    response_body
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
  if __FILE__ == $0
    ProcessPayment.new.main(false)
  end
end
