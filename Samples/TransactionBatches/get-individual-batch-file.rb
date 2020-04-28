require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Get_individual_batch_file
    def run(id)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction_batch_id(id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        id = "20190110"

        Get_individual_batch_file.new.run(id)
    end
end
