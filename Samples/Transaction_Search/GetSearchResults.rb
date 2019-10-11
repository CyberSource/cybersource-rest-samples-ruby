require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetSearchResults
    def run(search_id)
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_search(search_id)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <searchId>:"
        searchId = gets.chomp

        GetSearchResults.new.run(searchId)
    end
end
