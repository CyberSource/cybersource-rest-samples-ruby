require 'cybersource_rest_client'
require_relative './RetrieveInstrumentIdentifier.rb'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call InstrumentIdentifierApi,
# * Update an Instrument Identifier
# * Include the profile_id, token_id in the POST request to create a instrument identifier.

public
class UpdateInstrumentIdentifier
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    profile_id = "93B32398-AD51-4CC2-A682-EA3E93614EB1"

    request = CyberSource::Body1.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

    # Calling RetrieveInstrumentIdentifier sample code
    response = RetrieveInstrumentIdentifier.new.main
    resp = JSON.parse(response)
    id = resp['id']

    merchant_initiated_transaction = CyberSource::Tmsv1instrumentidentifiersAuthorizationOptionsMerchantInitiatedTransaction.new
    previous_transaction_id = "123456789012345"
    merchant_initiated_transaction.previous_transaction_id = previous_transaction_id

    initiator = CyberSource::Tmsv1instrumentidentifiersProcessingInformationAuthorizationOptionsInitiator.new
    initiator.merchant_initiated_transaction = merchant_initiated_transaction

    authorization_options = CyberSource::Tmsv1instrumentidentifiersProcessingInformationAuthorizationOptions.new
    authorization_options.initiator = initiator

    processing_information = CyberSource::Tmsv1instrumentidentifiersProcessingInformation.new
    processing_information.authorization_options = authorization_options

    request.processing_information = processing_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.tms_v1_instrumentidentifiers_token_id_patch(profile_id, id, request)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
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
    UpdateInstrumentIdentifier.new.main
  end
end