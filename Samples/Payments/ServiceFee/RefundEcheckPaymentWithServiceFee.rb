require 'cybersource_rest_client'
require_relative 'ProcessEcheckPaymentWithServiceFee.rb'
require_relative '../../../data/Configuration.rb'

public
class RefundEcheckPaymentWithServiceFee
  def main
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::RefundPaymentRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::RefundApi.new(api_client, config)

    capture_flag = true
    response = CreateEcheckPaymentWithServiceFee.new.main(capture_flag)
    resp = JSON.parse(response)
    id = resp['id']

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_refund_payment"
	
    request.client_reference_information = client_reference_information

    processing_info = CyberSource::Ptsv2paymentsidrefundsProcessingInformation.new
    processing_info.payment_solution = "Internet"

    request.processing_information = processing_info

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
    amount_details.total_amount = "225.00"
    amount_details.currency = "USD"
	amount_details.service_fee_amount = "30"

	order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    order_information.amount_details = amount_details
    order_information.bill_to = bill_to_information
	
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
  rescue StandardError => err
    puts err.message
  end
  
  if __FILE__ == $0
    RefundEcheckPaymentWithServiceFee.new.main
  end
end
