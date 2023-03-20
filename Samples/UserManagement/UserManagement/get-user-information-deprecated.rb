require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_user_information_deprecated
    def run()

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"permission_id"] = "CustomerProfileViewPermission"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::UserManagementApi.new(api_client, config)

        data, status_code, headers = api_instance.get_users(opts)

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
        Get_user_information_deprecated.new.run()
    end
end
