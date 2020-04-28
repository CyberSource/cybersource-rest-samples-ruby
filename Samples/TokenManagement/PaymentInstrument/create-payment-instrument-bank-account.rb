require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_payment_instrument_bank_account
    def run(profileid)
        request_obj = CyberSource::CreatePaymentInstrumentRequest.new
        bank_account = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedBankAccount.new
        bank_account.type = "savings"
        request_obj.bank_account = bank_account

        buyer_information = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedBuyerInformation.new
        buyer_information.company_tax_id = "12345"
        buyer_information.currency = "USD"
        buyer_information.date_of_birth = "2000-12-13"

        personal_identification = []
        personal_identification1 = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedBuyerInformationPersonalIdentification.new
        personal_identification1.id = "57684432111321"
        personal_identification1.type = "driver license"
        issued_by1 = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedBuyerInformationIssuedBy.new
        issued_by1.administrative_area = "CA"
        personal_identification1.issued_by = issued_by1
        personal_identification << personal_identification1

        buyer_information.personal_identification = personal_identification
        request_obj.buyer_information = buyer_information

        bill_to = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Smith"
        bill_to.company = "Cybersource"
        bill_to.address1 = "8310 Capital of Texas Highwas North"
        bill_to.address2 = "Bluffstone Drive"
        bill_to.locality = "Austin"
        bill_to.administrative_area = "TX"
        bill_to.postal_code = "78731"
        bill_to.country = "US"
        bill_to.email = "john.smith@test.com"
        bill_to.phone_number = "+44 2890447951"
        request_obj.bill_to = bill_to

        processing_information = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedProcessingInformation.new
        processing_information.bill_payment_program_enabled = true
        bank_transfer_options = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedProcessingInformationBankTransferOptions.new
        bank_transfer_options.sec_code = "WEB"
        processing_information.bank_transfer_options = bank_transfer_options
        request_obj.processing_information = processing_information

        merchant_information = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedMerchantInformation.new
        merchant_descriptor = CyberSource::TmsV1InstrumentIdentifiersPaymentInstrumentsGet200ResponseEmbeddedMerchantInformationMerchantDescriptor.new
        merchant_descriptor.alternate_name = "Branch Name"
        merchant_information.merchant_descriptor = merchant_descriptor
        request_obj.merchant_information = merchant_information

        instrument_identifier = CyberSource::Tmsv1paymentinstrumentsInstrumentIdentifier.new
        bank_account = CyberSource::Tmsv1instrumentidentifiersBankAccount.new
        bank_account.number = "4100"
        bank_account.routing_number = "071923284"
        instrument_identifier.bank_account = bank_account
        request_obj.instrument_identifier = instrument_identifier

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentInstrumentApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment_instrument(profileid, request_obj)

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
