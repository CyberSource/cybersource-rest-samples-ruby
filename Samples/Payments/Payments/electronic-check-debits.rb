require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Electronic_check_debits
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
        bank = CyberSource::Ptsv2paymentsPaymentInformationBank.new
        account = CyberSource::Ptsv2paymentsPaymentInformationBankAccount.new
        account.type = "C"
        account.number = "4100"
        bank.account = account
        bank.routing_number = "071923284"
        payment_information.bank = bank
        payment_type = CyberSource::Ptsv2paymentsPaymentInformationPaymentType.new
        payment_type.name = "CHECK"
        payment_information.payment_type = payment_type
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "100"
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
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Electronic_check_debits.new.run(true)
    end
end
