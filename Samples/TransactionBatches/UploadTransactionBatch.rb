require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class UploadTransactionBatch
    def run()
        file_name = "batchapiTest.csv"
        file_path = File.join(File.dirname(__FILE__), "..", "..", "resource", file_name)
        file_path = File.expand_path(file_path)

        file = File.new(file_path)

        config = MerchantConfiguration.new.batchUploadMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.upload_transaction_batch(file)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end

    if __FILE__ == $0
        UploadTransactionBatch.new.run()
    end
end
