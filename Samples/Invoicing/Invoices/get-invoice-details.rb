require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative './create-draft-invoice.rb'

public
class Get_invoice_details
    def run()
        id = (JSON.parse(Create_draft_invoice.new.run()))['id']
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InvoicesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_invoice(id)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_invoice_details.new.run()
    end
end
