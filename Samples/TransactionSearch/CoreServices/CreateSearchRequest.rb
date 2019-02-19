require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class CreateSearchRequest
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::TssV2TransactionsPostResponse.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)
    request.save = "false"
    request.name = "MRN"
    request.timezone = "America/Chicago"
    request.query = "clientReferenceInformation.code:TC50171_3"
    request.offset = 0
    request.limit = 100
    request.sort = "id:asc,submitTimeUtc:asc"
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.create_search(request)
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
  CreateSearchRequest.new.main
end

