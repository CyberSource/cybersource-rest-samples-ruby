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
        Delete_customer.new.run()
    end
end
