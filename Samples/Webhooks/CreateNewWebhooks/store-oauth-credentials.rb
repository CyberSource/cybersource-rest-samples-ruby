require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Store_oauth_credentials
    def run(v_c_correlation_id, v_c_sender_organization_id, v_c_permissions)
        request_obj = CyberSource::SaveSymEgressKey.new
        request_obj.client_request_action = "STORE"
        key_information = CyberSource::Kmsegressv2keyssymKeyInformation.new
        key_information.provider = "<INSERT ORGANIZATION ID HERE>"
        key_information.tenant = "nrtd"
        key_information.key_type = "oAuthClientCredentials"
        key_information.organization_id = "<INSERT ORGANIZATION ID HERE>"
        key_information.client_key_id = "client username"
        key_information.key = "client secret"
        key_information.expiry_duration = "365"
        request_obj.key_information = key_information
        opts = {}

        opts[:'v_c_correlation_id'] = v_c_correlation_id
        opts[:'create_webhook_request'] = request_obj

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreateNewWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.save_sym_egress_key(v_c_sender_organization_id, v_c_permissions, opts)

        puts status_code, headers, data

        write_log_audit(status_code)
        return data, status_code, headers
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Store_oauth_credentials.new.run(v_c_correlation_id, v_c_sender_organization_id, v_c_permissions)
    end
end