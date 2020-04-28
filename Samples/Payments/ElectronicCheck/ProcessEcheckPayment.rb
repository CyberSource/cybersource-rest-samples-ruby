require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call PaymentApi,
# * for Core Services - Process Payment
# * createPayment method will create a new payment

public
class CreateEcheckPayment
  def main(capture_flag)
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
	
    sub_merchant_information = CyberSource::Ptsv2paymentsAggregatorInformationSubMerchant.new
    sub_merchant_information.card_acceptor_id = "1234567890"
    sub_merchant_information.country = "US"
    sub_merchant_information.phone_number = "4158880000"
    sub_merchant_information.address1 = "1 Market St"
    sub_merchant_information.postal_code = "94105"
    sub_merchant_information.locality = "san francisco"
    sub_merchant_information.name = "ABC Company"
    sub_merchant_information.administrative_area = "CA"
    sub_merchant_information.region = "PEN"
    sub_merchant_information.email = "test@cybs.com"
    
    aggregator_information = CyberSource::Ptsv2paymentsAggregatorInformation.new
	aggregator_information.sub_merchant = sub_merchant_information
    aggregator_information.name = "V-Internatio"
    aggregator_information.aggregator_id = "123456789"
	
    request.aggregator_information = aggregator_information
    
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
    bill_to_information.email = "test@cybs.com"

    amount_information = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_information.total_amount = "102.21"
    amount_information.currency = "USD"
	
    order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    order_information.bill_to = bill_to_information	
    order_information.amount_details = amount_information
	
    request.order_information = order_information

    bank_account = CyberSource::Ptsv2paymentsPaymentInformationBankAccount.new
	bank_account.number = "4100"
	bank_account.type = "C"
	bank_account.check_number = "123456"
	
	bank = CyberSource::Ptsv2paymentsPaymentInformationBank.new
	bank.account = bank_account
	bank.routing_number = "071923284"
	
	payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
    payment_information.bank = bank
	
    request.payment_information = payment_information
    data, status_code, headers = api_instance.create_payment(request)
	
    puts data, status_code, headers
	
    data
  rescue StandardError => err
    puts err.message
  end
  
  if __FILE__ == $0
    CreateEcheckPayment.new.main(false)
  end
end
