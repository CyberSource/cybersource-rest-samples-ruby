require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_customer_payment_instrument_bank_account
    def run()
        customer_token_id = "AB695DA801DD1BB6E05341588E0A3BDC"
        request_obj = CyberSource::PostCustomerPaymentInstrumentRequest.new
        bank_account = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBankAccount.new
        bank_account.type = "savings"
        request_obj.bank_account = bank_account

        buyer_information = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBuyerInformation.new
        buyer_information.company_tax_id = "12345"
        buyer_information.currency = "USD"
        buyer_information.date_of_birth = "2000-12-13"

        personal_identification = []
        personal_identification1 = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBuyerInformationPersonalIdentification.new
        personal_identification1.id = "57684432111321"
        personal_identification1.type = "driver license"
        issued_by1 = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBuyerInformationIssuedBy.new
        issued_by1.administrative_area = "CA"
        personal_identification1.issued_by = issued_by1
        personal_identification << personal_identification1

        buyer_information.personal_identification = personal_identification
        request_obj.buyer_information = buyer_information

        bill_to = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.company = "CyberSource"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "San Francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        request_obj.bill_to = bill_to

        processing_information = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentProcessingInformation.new
        bank_transfer_options = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentProcessingInformationBankTransferOptions.new
        bank_transfer_options.sec_code = "WEB"
        processing_information.bank_transfer_options = bank_transfer_options
        request_obj.processing_information = processing_information

        instrument_identifier = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentInstrumentIdentifier.new
        instrument_identifier.id = "A7A91A2CA872B272E05340588D0A0699"
        request_obj.instrument_identifier = instrument_identifier

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerPaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.post_customer_payment_instrument(customer_token_id, request_obj)

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
        Create_customer_payment_instrument_bank_account.new.run()
    end
end
