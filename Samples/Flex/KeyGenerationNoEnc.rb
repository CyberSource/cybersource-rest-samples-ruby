require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

# * This is a sample code to call KeyGenerationApi,
# * Generate Key - with Encryption Type as none
# * GeneratePublickey method will create a new Public Key and Key ID

public
class NoEncGeneratekey
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::KeyParameters.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::KeyGenerationApi.new(api_client, config)
    request.encryption_type = "None"
    options = {}
    options[:'generate_public_key_request'] = request
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.generate_public_key(options)
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
    NoEncGeneratekey.new.main
  end
end