require 'cybersource_rest_client'
require_relative 'CapturePayment.rb'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call VoidApi,
# * Void a Capture
# * Include the Capture ID in the POST request to cancel the Payment Capture.

public
class VoidCapture
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::VoidCaptureRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::VoidApi.new(api_client, config)

    # Calling Capturepayment Sample code 
    response = CapturePayment.new.main
    resp = JSON.parse(response)
    id = resp['id']

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_capture_void"
    request.client_reference_information = client_reference_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.void_capture(request, id)
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
    VoidCapture.new.main
  end
end
