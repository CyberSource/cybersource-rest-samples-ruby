require 'cybersource_rest_client'
require_relative './create-instrument-identifier-card.rb'
require_relative '../../../data/Configuration.rb'

public
class Delete_instrument_identifier
    def run()
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'
        token_id = (JSON.parse(Create_instrument_identifier_card.new.run(profileid)))['id']

        opts = {}
        opts[:"profile-id"] = profileid

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_instrument_identifier(token_id, opts)

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
        Delete_instrument_identifier.new.run()
    end
end
