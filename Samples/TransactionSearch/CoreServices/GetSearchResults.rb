require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class GetSearchResults
  def main()
	  id = "efa74d1a-9765-4d2c-968c-72c7261b3b27"
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new

    api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)
    data, status_code, headers = api_instance.get_search(id)
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  GetSearchResults.new.main
end
