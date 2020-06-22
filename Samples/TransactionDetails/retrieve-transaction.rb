require 'cybersource_rest_client'
require_relative '../Payments/Payments/simple-authorizationinternet.rb'
require_relative '../../data/Configuration.rb'

public
class Retrieve_transaction
    def run()
        id = (JSON.parse(Simple_authorizationinternet.new.run(false)))['id']
        sleep(15)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction(id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Retrieve_transaction.new.run()
    end
end
