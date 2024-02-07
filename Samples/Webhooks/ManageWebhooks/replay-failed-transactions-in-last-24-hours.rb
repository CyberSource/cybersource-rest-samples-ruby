require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Replay_failed_transactions_in_last_24_hours
    def run(webhook_id)
        request_obj = CyberSource::ReplayWebhooksRequest.new
        by_delivery_status = CyberSource::Nrtfv1webhookswebhookIdreplaysByDeliveryStatus.new
        by_delivery_status.status = "FAILED"
        by_delivery_status.hours_back = 24
        by_delivery_status.product_id = "tokenManagement"
        by_delivery_status.event_type = "tms.token.created"
        request_obj.by_delivery_status = by_delivery_status
        opts = {}

        opts[:'replay_webhooks_request'] = request_obj

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ManageWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.replay_previous_webhooks(webhook_id, opts)

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
        Replay_failed_transactions_in_last_24_hours.new.run(webhook_id)
    end
end