require 'cybersource_rest_client'
require_relative './create-customer.rb'
require_relative '../../../data/Configuration.rb'

public
class Delete_customer
    def run()
        customer_token_id = (JSON.parse(Create_customer.new.run()))['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CustomerApi.new(api_client, config)

        data, status_code, headers = api_instance.delete_customer(customer_token_id)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Delete_customer.new.run()
    end
end
