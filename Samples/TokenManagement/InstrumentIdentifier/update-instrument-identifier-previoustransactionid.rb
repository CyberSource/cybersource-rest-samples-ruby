require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Update_instrument_identifier_previoustransactionid
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	instrument_identifier_token_id = "7010000000016241111"
	
        request_obj = CyberSource::PatchInstrumentIdentifierRequest.new
        processing_information = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierProcessingInformation.new
        authorization_options = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierProcessingInformationAuthorizationOptions.new
        initiator = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierProcessingInformationAuthorizationOptionsInitiator.new
        merchant_initiated_transaction = CyberSource::Tmsv2customersEmbeddedDefaultPaymentInstrumentEmbeddedInstrumentIdentifierProcessingInformationAuthorizationOptionsInitiatorMerchantInitiatedTransaction.new
        merchant_initiated_transaction.previous_transaction_id = "123456789012345"
        initiator.merchant_initiated_transaction = merchant_initiated_transaction
        authorization_options.initiator = initiator
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.patch_instrument_identifier(instrument_identifier_token_id, request_obj, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Update_instrument_identifier_previoustransactionid.new.run()
    end
end
