require 'cybersource_rest_client'
require_relative './create-search-request.rb'
require_relative '../../data/Configuration.rb'

public
class Get_search_results
    def run()
        search_id = (JSON.parse(Create_search_request.new.run))['search_id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_search(search_id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_search_results.new.run()
    end
end
