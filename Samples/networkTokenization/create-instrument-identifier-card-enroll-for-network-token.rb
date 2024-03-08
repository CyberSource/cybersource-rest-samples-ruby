# frozen_string_literal: true

require 'cybersource_rest_client'
require_relative '../../data/Configuration'

public
class Create_instrument_identifier_card_enroll_for_network_token
  def run(profile_id = nil )
    if profile_id == nil?
      profile_id = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
    end
    request_obj = CyberSource::PostInstrumentIdentifierRequest.new
    request_obj.type = "enrollable card"
    card = CyberSource::TmsEmbeddedInstrumentIdentifierCard.new
    card.number = "5204245750003216"
    card.expiration_month = "12"
    card.expiration_year = "2025"
    request_obj.card = card

    opts = {}
    opts[:"profile-id"] = profile_id

    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)
    data, status_code, headers = api_instance.post_instrument_identifier(request_obj, opts)
    puts data, status_code, headers
    write_log_audit(status_code)
    return data
  rescue StandardError => err
      write_log_audit(err.code)
    puts err.message
  end

  def write_log_audit(status)
    filename = ($0.split("/")).last.split(".")[0]
    puts "[Sample Code Testing] [#{filename}] #{status}"
  end

  if __FILE__ == $0
    profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
    Create_instrument_identifier_card_enroll_for_network_token.new.run(profileid)
  end
end
