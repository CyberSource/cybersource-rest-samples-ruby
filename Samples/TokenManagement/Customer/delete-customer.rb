require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative './create-customer.rb'

public
class Delete_customer
    def run()
        opts = {}
	opts['profile-id'] = "93B32398-AD51-4CC2-A682-EA3E93614EB1"
	customer_token_id = (JSON.parse(Create_customer.new.run()))['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_customer(customer_token_id, opts)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Delete_customer.new.run()
    end
end
