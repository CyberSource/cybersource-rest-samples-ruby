require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call CreditApi,
# * Create an Credit
# * CreateCredit method will create a new Credit.

public
class ProcessCreditWithServiceFee
  def main
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::CreateCreditRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::CreditApi.new(api_client, config)

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_credit"
    request.client_reference_information = client_reference_information
    
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
    bill_to_information.email = "test@cybs.com"
    order_information.bill_to = bill_to_information
    request.order_information = order_information

    amount_information = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_information.total_amount = "102.21"
    amount_information.service_fee_amount="30"
    amount_information.currency = "USD"
    order_information.amount_details = amount_information
    request.order_information = order_information

    payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
    card_information =CyberSource::Ptsv2paymentsPaymentInformationCard.new
    card_information.expiration_year = "2031"
    card_information.number = "5555555555554444"
    card_information.expiration_month = "12"
    card_information.type = "002"
    payment_information.card = card_information
    request.payment_information = payment_information
    data, status_code, headers = api_instance.create_credit(request)
    puts data, status_code, headers
    data
  rescue StandardError => err
    puts err.message
  end
  if __FILE__ == $0
    ProcessCreditWithServiceFee.new.main
  end
end
