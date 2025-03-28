require 'cybersource_rest_client'
require_relative '../../data/ConfigurationWithMLE.rb'

public
class PaymentsWithMLEControlFromMapConfigOnly
  def run(flag)
    request_obj = CyberSource::CreatePaymentRequest.new
    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "TC50171_3"
    request_obj.client_reference_information = client_reference_information

    processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
    processing_information.capture = false
    if flag == true
      processing_information.capture = true
    end
    request_obj.processing_information = processing_information

    payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
    card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
    card.number = "4111111111111111"
    card.expiration_month = "12"
    card.expiration_year = "2031"
    payment_information.card = card
    request_obj.payment_information = payment_information

    order_information = CyberSource::Ptsv2paymentsOrderInformation.new
    amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
    amount_details.total_amount = "102.21"
    amount_details.currency = "USD"
    order_information.amount_details = amount_details
    bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
    bill_to.first_name = "John"
    bill_to.last_name = "Doe"
    bill_to.address1 = "1 Market St"
    bill_to.locality = "san francisco"
    bill_to.administrative_area = "CA"
    bill_to.postal_code = "94105"
    bill_to.country = "US"
    bill_to.email = "test@cybs.com"
    bill_to.phone_number = "4158880000"
    order_information.bill_to = bill_to
    request_obj.order_information = order_information

    config = MerchantConfiguration.merchantConfigPropWithMLEMAPAndGlobalFlag
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PaymentsApi.new(api_client, config)

    data, status_code, headers = api_instance.create_payment(request_obj)

    puts data, status_code, headers
    write_log_audit(status_code)
    return data
  rescue StandardError => err
    write_log_audit(err.code)
    puts err.message
  end

  def write_log_audit(status)
    filename = ($0.split("/")).last.split(".")[0]
    puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  if __FILE__ == $0
    PaymentsWithMLEControlFromMapConfigOnly.new.run(false)
  end
end
