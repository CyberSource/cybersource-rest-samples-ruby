require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetListOfBatchFiles
    def run()
        start_time = "2019-05-22T01:47:57.000Z"
        end_time = "2019-07-22T22:47:57.000Z"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction_batches(start_time, end_time)
	puts data, status_code, headers
        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing query parameter <startTime>:"
        startTime = gets.chomp
        puts "\nInput missing query parameter <endTime>:"
        endTime = gets.chomp

        GetListOfBatchFiles.new.run()
    end
end
