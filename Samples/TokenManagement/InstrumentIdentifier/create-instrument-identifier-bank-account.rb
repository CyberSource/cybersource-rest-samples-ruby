require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class create_instrument_identifier_bank_account
    def run(profileid)
        request_obj = CyberSource::CreateInstrumentIdentifierRequest.new
        bank_account = CyberSource::Tmsv1instrumentidentifiersBankAccount.new
        bank_account.number = "4100"
        bank_account.routing_number = "071923284"
        request_obj.bank_account = bank_account

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InstrumentIdentifierApi.new(api_client, config)

        data, status_code, headers = api_instance.create_instrument_identifier(profileid, request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        profileid = '93B32398-AD51-4CC2-A682-EA3E93614EB1'

        create_instrument_identifier_bank_account.new.run(profileid)
    end
end
