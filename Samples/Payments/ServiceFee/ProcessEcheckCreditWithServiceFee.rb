require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class ProcessEcheckCreditWithServiceFee
  def main
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::CreateCreditRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::CreditApi.new(api_client, config)

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_credit"
	
    request.client_reference_information = client_reference_information
    
    bill_to_information = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
    bill_to_information.country = "US"
    bill_to_information.last_name = "Deo"
    bill_to_information.address1 = "1 Market St"
    bill_to_information.postal_code = "94105"
    bill_to_information.locality = "san francisco"
    bill_to_information.administrative_area = "CA"
    bill_to_information.first_name = "John"
    bill_to_information.phone_number = "4158880000"
    bill_to_information.email = "test@cybs.com"	

    amount_information = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_information.total_amount = "102.21"
    amount_information.currency = "USD"
    amount_information.service_fee_amount="30"
	
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
	
    data, status_code, headers = api_instance.create_credit(request)
	
    puts data, status_code, headers
	
    data
  rescue StandardError => err
    puts err.message
  end
  
  if __FILE__ == $0
    ProcessEcheckCreditWithServiceFee.new.main
  end
end
