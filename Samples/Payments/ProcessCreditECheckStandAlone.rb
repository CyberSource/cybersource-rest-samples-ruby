require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class ProcessCreditECheckStandAlone
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC46125-1"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2creditsProcessingInformation.new
        processing_information.commerce_indicator = "internet"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        bank = CyberSource::Ptsv2paymentsPaymentInformationBank.new
        account = CyberSource::Ptsv2paymentsPaymentInformationBankAccount.new
        account.type = "C"
        account.number = "4100"
        account.check_number = "123456"
        bank.account = account
        bank.routing_number = "071923284"
        payment_information.bank = bank
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "100"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsidcapturesOrderInformationBillTo.new
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

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        ProcessCreditECheckStandAlone.new.run()
    end
end
