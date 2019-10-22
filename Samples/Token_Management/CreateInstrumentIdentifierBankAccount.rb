require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class CreateInstrumentIdentifierBankAccount
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
        puts "\nInput missing header parameter <profile-id>:"
        profileid = gets.chomp

        CreateInstrumentIdentifierBankAccount.new.run(profileid)
    end
end
