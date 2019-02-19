require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class RetrieveTransaction
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    id = "5408386919326811103004" 
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::TransactionDetailsApi.new(api_client, config)
    response_body, response_code, response_headers = api_instance.get_transaction(id)
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
  RetrieveTransaction.new.main
end


