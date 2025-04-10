require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class UploadTransactionBatch
    def run()
        begin
            # Get the file path from the resources folder
            file_name = "batchapiTest.csv"
            file_path = File.join(File.dirname(__FILE__), "../../../resources", file_name)

            # Create a File object
            file = File.new(file_path)

            # SDK needs file object to send to Cybersource API endpoint
            config = MerchantConfiguration.new.merchantConfigProp()
            api_client = CyberSource::ApiClient.new
            api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

            # Upload the transaction batch
            data, status_code, headers = api_instance.upload_transaction_batch(file)

            puts "ResponseCode: #{status_code}"
            puts "ResponseMessage: #{data}"
            write_log_audit(status_code)
        rescue StandardError => err
            write_log_audit(err.respond_to?(:code) ? err.code : "Error")
            puts err.message
        end
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        UploadTransactionBatch.new.run()
    end
end
