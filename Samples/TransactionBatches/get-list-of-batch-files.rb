require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Get_list_of_batch_files
    def run()
        start_time = "2020-02-22T01:47:57.000Z"
        end_time = "2020-02-22T22:47:57.000Z"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction_batches(start_time, end_time)

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
        Get_list_of_batch_files.new.run()
    end
end
