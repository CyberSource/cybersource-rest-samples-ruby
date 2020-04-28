require 'cybersource_rest_client'
require_relative 'ProcessEcheckPayment.rb'
require_relative '../../../data/Configuration.rb'

public 
class RefundEcheckPayment
  def main
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::RefundPaymentRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::RefundApi.new(api_client, config)

    capture_flag = true
    response = CreateEcheckPayment.new.main(capture_flag)
    resp = JSON.parse(response)
    id = resp['id']

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_refund_payment"
	
    request.client_reference_information = client_reference_information
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

    amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_details.total_amount = "102.21"
    amount_details.currency ="USD"

	order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    order_information.bill_to = bill_to_information
    order_information.amount_details = amount_details
	
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
	
    data, status_code, headers = api_instance.refund_payment(request, id)
	
    puts data, status_code, headers	
    data
  rescue StandardError => err
    puts err.message
  end
  
  if __FILE__ == $0
    RefundEcheckPayment.new.main
  end
end
