require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

# * This is a sample code to call PaymentInstrumentApi,
# * Process an Payment Instrument
# * Include the profile_id in the POST request to create a new payment instrument.

public
class CreatePaymentInstrument
  def main
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    profile_id = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
    request = CyberSource::Body2.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PaymentInstrumentsApi.new(api_client, config)

    card = CyberSource::Tmsv1paymentinstrumentsCard.new
    card.expiration_month = "09"
    card.expiration_year = "2022"
    card.type = "visa"
    request.card = card

    bill_to = CyberSource::Tmsv1paymentinstrumentsBillTo.new
    bill_to.first_name = "John"
    bill_to.last_name = "Deo"
    bill_to.company = "CyberSource"
    bill_to.address1 = "12 Main Street"
    bill_to.address2 = "20 My Street"
    bill_to.locality = "Foster City"
    bill_to.administrative_area = "CA"
    bill_to.postal_code = "90200"
    bill_to.country = "US"
    bill_to.email = "john.smith@example.com"
    bill_to.phone_number = "555123456"
    request.bill_to = bill_to
      
    instrument_identifier_card = CyberSource::Tmsv1instrumentidentifiersCard.new
    instrument_identifier_card.number = "4111111111111111"

    instrument_identifier = CyberSource::Tmsv1paymentinstrumentsInstrumentIdentifier.new
    instrument_identifier.card = instrument_identifier_card
    request.instrument_identifier = instrument_identifier
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.tms_v1_paymentinstruments_post(profile_id, request)
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
    CreatePaymentInstrument.new.main
  end
end