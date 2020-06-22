require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_user_information_deprecated
    def run()

        opts = {}
        opts[:"organization-id"] = "testrest"
        opts[:"permission-id"] = "CustomerProfileViewPermission"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::UserManagementApi.new(api_client, config)

        data, status_code, headers = api_instance.get_users(opts)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Get_user_information_deprecated.new.run()
    end
end
