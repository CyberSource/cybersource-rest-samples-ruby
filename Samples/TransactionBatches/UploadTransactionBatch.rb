require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class UploadTransactionBatch
    def run()
            # Get the file path from the resources folder
            file_name = "batchapiTest.csv"
            file_path = File.join(File.dirname(__FILE__), "../../../resources", file_name)

            # Create a File object
            file = File.new(file_path)

            # SDK needs file object to send to Cybersource API endpoint
            config = MerchantConfiguration.new.batchUploadMerchantConfigProp()
            api_client = CyberSource::ApiClient.new
            api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

            # Upload the transaction batch
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
