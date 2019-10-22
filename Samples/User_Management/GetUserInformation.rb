require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetUserInformation
    def run()

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"user_name"] = nil
        opts[:"permission_id"] = "CustomerProfileViewPermission"
        opts[:"role_id"] = nil

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::UserManagementApi.new(api_client, config)

        data, status_code, headers = api_instance.get_users(opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing query parameter <organizationId>:"
        organizationId = gets.chomp
        puts "\nInput missing query parameter <userName>:"
        userName = gets.chomp
        puts "\nInput missing query parameter <permissionId>:"
        permissionId = gets.chomp
        puts "\nInput missing query parameter <roleId>:"
        roleId = gets.chomp

        GetUserInformation.new.run(organizationId, userName, permissionId, roleId)
    end
end
