require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_payment_instrument_bank_account
    def run(profileid)
        request_obj = CyberSource::PostPaymentInstrumentRequest.new
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
        bill_to.company = "Cybersource"
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
        bank_transfer_options.se_c_code = "WEB"
        processing_information.bank_transfer_options = bank_transfer_options
        request_obj.processing_information = processing_information

        instrument_identifier = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentInstrumentIdentifier.new
        instrument_identifier.id = "A7A91A2CA872B272E05340588D0A0699"
        request_obj.instrument_identifier = instrument_identifier

        opts = {}
        opts[:"profile-id"] = profileid

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.post_payment_instrument(request_obj, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'

        Create_payment_instrument_bank_account.new.run(profileid)
    end
end
