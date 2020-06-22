require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Retrieve_instrument_identifier
    def run()
        opts = {}
        opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"

        token_id = "7010000000016241111"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.get_instrument_identifier(token_id, opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Retrieve_instrument_identifier.new.run()
    end
end
