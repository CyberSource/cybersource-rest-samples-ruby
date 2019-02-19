require 'cybersource_rest_client'
require_relative './ProcessPayment.rb'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call ReversalApi,
# * Process an Authorization Reversal
# * Include the payment ID in the POST request to reverse the payment amount.

public
class ProcessAuthorizationReversal
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::AuthReversalRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::ReversalApi.new(api_client, config)

    # Calling ProcessPayment Sample code 
    capture_flag = false
    response = ProcessPayment.new.main(capture_flag)
    resp = JSON.parse(response)
    id = resp['id']

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_reversal"
    request.client_reference_information = client_reference_information

    reversal_information = CyberSource::Ptsv2paymentsidreversalsReversalInformation.new
    reversal_information.reason = "testing"

    amount_details = CyberSource::Ptsv2paymentsidreversalsReversalInformationAmountDetails.new
    amount_details.total_amount = "102.21"

    reversal_information.amount_details = amount_details
    request.reversal_information = reversal_information
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.auth_reversal(id, request)
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
    ProcessAuthorizationReversal.new.main
  end
end
