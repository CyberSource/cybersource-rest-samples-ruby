require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Update_webhook
    def run(webhook_id)
        request_obj = CyberSource::UpdateWebhookRequest.new
        request_obj.name = "My Sample Webhook"
        request_obj.description = "Update to my sample webhook"
        request_obj.organization_id = "<INSERT ORGANIZATION ID HERE>"
        request_obj.product_id = "terminalManagement"

        event_types =  []
        event_types << "terminalManagement.assignment.update"
        event_types << "terminalManagement.status.update"
        request_obj.event_types = event_types
        request_obj.webhook_url = "https://MyWebhookServer.com:8443:/simulateClient"
        request_obj.health_check_url = "https://MyWebhookServer.com:8443:/simulateClientHealthCheck"
        request_obj.status = "INACTIVE"
        notification_scope = CyberSource::Notificationsubscriptionsv1webhooksNotificationScope.new
        notification_scope.scope = "SELF"
        request_obj.notification_scope = notification_scope
        opts = {}

        opts[:'update_webhook_request'] = request_obj

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ManageWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.update_webhook_subscription(webhook_id, opts)

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
        Update_webhook.new.run(webhook_id)
    end
end