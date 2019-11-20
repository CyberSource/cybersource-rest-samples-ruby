require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call PaymentApi,
# * for Core Services - Process Payment
# * createPayment method will create a new payment

public
class CreatePayment
  def main(capture_flag)
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::CreatePaymentRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PaymentsApi.new(api_client, config)
    
    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "1234567890"
    request.client_reference_information = client_reference_information
    
    processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
    processing_information.commerce_indicator = "internet"
    processing_information.capture = false
    request.processing_information = processing_information
    
    order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    bill_to_information = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
    bill_to_information.country = "US"
    bill_to_information.last_name = "Deo"
    bill_to_information.address1 = "1 Market St"
    bill_to_information.postal_code = "94105"
    bill_to_information.locality = "san francisco"
    bill_to_information.administrative_area = "CA"
    bill_to_information.first_name = "John"
    bill_to_information.phone_number = "4158880000"
    bill_to_information.company = "Visa"
    bill_to_information.email = "test@cybs.com"
    order_information.bill_to = bill_to_information
    request.order_information = order_information

    amount_information = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_information.total_amount = "0.00"
    amount_information.currency = "USD"
    order_information.amount_details = amount_information
    request.order_information = order_information

    payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
    card_information =CyberSource::Ptsv2paymentsPaymentInformationCard.new
    card_information.expiration_year = "2031"
    card_information.number = "5555555555554444"
    card_information.security_code = "123"
    card_information.expiration_month = "12"
    payment_information.card = card_information
    request.payment_information = payment_information
    
    data, status_code, headers = api_instance.create_payment(request)
    puts data, status_code, headers
    data
  rescue StandardError => err
    puts err.message
  end
  if __FILE__ == $0
    CreatePayment.new.main(false)
  end
end
