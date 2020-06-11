require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_invoice_settings
    def run()
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InvoiceSettingsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_invoice_settings()

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_invoice_settings.new.run()
    end
end
