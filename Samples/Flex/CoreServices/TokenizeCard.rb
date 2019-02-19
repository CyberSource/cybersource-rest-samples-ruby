require 'cybersource_rest_client'
require_relative '../VerifyToken.rb'
require_relative '../KeyGenerationNoEnc.rb'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call KeyGenerationApi which will return key and
# * TokenizationApi Returns a token representing the supplied card details.
# * to verify the token with the key generated.

public
class TokenizeCard
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::TokenizeRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::FlexTokenApi.new(api_client, config)
    key_generation_response = NoEncGeneratekey.new.main
    resp = JSON.parse(key_generation_response)
    request.key_id = resp['keyId']
    public_key = resp['der']['publicKey']

    card_info = CyberSource::Flexv1tokensCardInfo.new
    card_info.card_number = "5555555555554444"
    card_info.card_expiration_month = "03"
    card_info.card_expiration_year = "2031"
    card_info.card_type = "002"
    request.card_info =  card_info
    options = {}
    options[:'tokenize_request'] = request
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.tokenize(options)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
    verify = VerifyToken.new.verify(public_key, response_body)
    puts "Token Verification: #{verify}"
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
    TokenizeCard.new.main
  end
end