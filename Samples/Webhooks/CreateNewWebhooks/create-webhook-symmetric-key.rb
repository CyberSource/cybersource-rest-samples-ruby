require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_webhook_symmetric_key
    def run(v_c_correlation_id, v_c_sender_organization_id, v_c_permissions)
        request_obj = CyberSource::SaveSymEgressKey.new
        request_obj.client_request_action = "CREATE"
        key_information = CyberSource::Kmsegressv2keyssymKeyInformation.new
        key_information.provider = "nrtd"
        key_information.tenant = "<INSERT ORGANIZATION ID HERE>"
        key_information.key_type = "sharedSecret"
        key_information.organization_id = "<INSERT ORGANIZATION ID HERE>"
        request_obj.key_information = key_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreateNewWebhooksApi.new(api_client, config)
        opts = {}

        opts[:"v_c_correlation_id"] = v_c_correlation_id
        opts[:'save_sym_egress_key'] = request_obj

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
        Create_webhook_symmetric_key.new.run(v_c_correlation_id, v_c_sender_organization_id, v_c_permissions)
    end
end