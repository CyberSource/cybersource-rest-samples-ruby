require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_webhook_using_oauth_with_jwt
    def run()
        request_obj = CyberSource::CreateWebhook.new
        request_obj.name = "My Custom Webhook"
        request_obj.description = "Sample Webhook from Developer Center"
        request_obj.organization_id = "organizationId"
        request_obj.product_id = "terminalManagement"

        event_types =  []
        event_types << "terminalManagement.assignment.update"
        request_obj.event_types = event_types
        request_obj.webhook_url = "https://MyWebhookServer.com:8443/simulateClient"
        request_obj.health_check_url = "https://MyWebhookServer.com:8443/simulateClientHealthCheck"
        request_obj.notification_scope = "SELF"
        retry_policy = CyberSource::Notificationsubscriptionsv1webhooksRetryPolicy.new
        retry_policy.algorithm = "ARITHMETIC"
        retry_policy.first_retry = 1
        retry_policy.interval = 1
        retry_policy.number_of_retries = 3
        retry_policy.deactivate_flag = "false"
        retry_policy.repeat_sequence_count = 0
        retry_policy.repeat_sequence_wait_time = 0
        request_obj.retry_policy = retry_policy

        security_policy = CyberSource::Notificationsubscriptionsv1webhooksSecurityPolicy1.new
        security_policy.security_type = "oAuth_JWT"
        security_policy.proxy_type = "external"
        config = CyberSource::Notificationsubscriptionsv1webhooksSecurityPolicy1Config.new
        config.o_auth_token_expiry = "365"
        config.o_auth_u_r_l = "https://MyWebhookServer.com:8443/oAuthToken"
        config.o_auth_token_type = "Bearer"
        additional_config = CyberSource::Notificationsubscriptionsv1webhooksSecurityPolicy1ConfigAdditionalConfig.new
        additional_config.aud = "idp.api.myServer.com"
        additional_config.client_id = "650538A1-7AB0-AD3A-51AB-932ABC57AD70"
        additional_config.key_id = "y-daaaAVyF0176M7-eAZ34pR9Ts"
        additional_config.scope = "merchantacq:rte:write"
        config.additional_config = additional_config
        security_policy.config = config
        request_obj.security_policy = security_policy

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreateNewWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.create_webhook(request_obj, opts)

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
        Create_webhook_using_oauth_with_jwt.new.run()
    end
end