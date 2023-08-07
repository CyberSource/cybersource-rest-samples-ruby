# frozen_string_literal: true

require 'cybersource_rest_client'
require_relative '../../data/Configuration'


public
class Payment_credentials_from_network_token
  def run
    # token_id of your instrument
    token_id = '7010000000008573216'
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::TokenApi.new(api_client, config)
    data, headers, status_code = api_instance.post_token_payment_credentials(token_id)
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

    Payment_credentials_from_network_token.new.run
  end
end
