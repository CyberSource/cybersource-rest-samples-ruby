require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class RetrieveTransaction
    def run(id)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction(id)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <id>:"
        id = gets.chomp

        RetrieveTransaction.new.run(id)
    end
end
