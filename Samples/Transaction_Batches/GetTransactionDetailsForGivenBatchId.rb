require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetTransactionDetailsForGivenBatchId
    def run(id)

        opts = {}
        opts[:"upload_date"] = "2019-08-30"
        opts[:"status"] = "Rejected"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction_batch_details(id, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <id>:"
        id = gets.chomp
        puts "\nInput missing query parameter <uploadDate>:"
        uploadDate = gets.chomp
        puts "\nInput missing query parameter <status>:"
        status = gets.chomp

        GetTransactionDetailsForGivenBatchId.new.run(id, uploadDate, status)
    end
end
