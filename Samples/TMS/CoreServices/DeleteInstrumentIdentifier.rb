require 'cybersource_rest_client'
require_relative './RetrieveInstrumentIdentifier.rb'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call InstrumentIdentifierApi,
# * Delete an Instrument Identifier
# * Include the profile_id and instrument Id in the DELETE request to delete a instrument identifier.

public
class DeleteInstrumentIdentifier
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    profile_id = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::InstrumentIdentifierApi.new(api_client,config)

    # Calling RetrieveInstrumentIdentifier sample code
    response = RetrieveInstrumentIdentifier.new.main
    resp = JSON.parse(response)
    id = resp['id']
    response_body, response_code, response_headers = api_instance.tms_v1_instrumentidentifiers_token_id_delete(profile_id, id)
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
    DeleteInstrumentIdentifier.new.main
  end
end
