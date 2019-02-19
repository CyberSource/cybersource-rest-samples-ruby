require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call InstrumentIdentifierApi,
# * Process an Instrument Identifier
# * Include the profile_id in the POST request to create a new instrument identifier.

public
class CreateInstrumentIdentifier
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    profile_id = '93B32398-AD51-4CC2-A682-EA3E93614EB1'

    request = CyberSource::Body.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::InstrumentIdentifiersApi.new(api_client, config)

    instrument_card_info = CyberSource::Tmsv1instrumentidentifiersCard.new
    instrument_card_info.number = "1234567890123"
    request.card = instrument_card_info

    

    instrument_processing_information_merchant_initiator = CyberSource::Tmsv1instrumentidentifiersAuthorizationOptionsMerchantInitiatedTransaction.new
    instrument_processing_information_merchant_initiator.previous_transaction_id = "123456789012345"

    
    instrument_processing_information_initiator = CyberSource::Tmsv1instrumentidentifiersProcessingInformationAuthorizationOptionsInitiator.new
    instrument_processing_information_initiator.merchant_initiated_transaction = instrument_processing_information_merchant_initiator

    instrument_processing_information_auth = CyberSource::Tmsv1instrumentidentifiersProcessingInformationAuthorizationOptions.new
    instrument_processing_information_auth.initiator = instrument_processing_information_initiator

    instrument_processing_information = CyberSource::Tmsv1instrumentidentifiersProcessingInformation.new
    instrument_processing_information.authorization_options = instrument_processing_information_auth
    
    request.processing_information = instrument_processing_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.tms_v1_instrumentidentifiers_post(profile_id, request)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
    response_body
  rescue StandardError => err
    if (err.respond_to? :response_headers) || (err.respond_to? :response_body) || (err.respond_to? :code)
      puts "\nAPI REQUEST HEADERS:"
      puts api_client.request_headers
      puts "\nAPI RESPONSE CODE: \n#{err.code}", "\nAPI RESPONSE HEADERS: \n#{err.response_headers}", "\nAPI RESPONSE BODY: \n#{err.response_body}"
    else
      puts err.message
    end
  ensure
    puts "\n[END] REQUEST & RESPONSE OF: #{self.class.name}"
  end
  if __FILE__ == $0
    CreateInstrumentIdentifier.new.main
  end
end