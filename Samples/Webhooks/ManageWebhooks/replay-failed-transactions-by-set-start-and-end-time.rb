require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Replay_failed_transactions_by_set_start_and_end_time
    def run(webhook_id)
        request_obj = CyberSource::ReplayWebhooks.new
        by_delivery_status = CyberSource::Nrtfv1webhookswebhookIdreplaysByDeliveryStatus.new
        by_delivery_status.status = "FAILED"
        by_delivery_status.start_time = "2021-01-01T15:05:52.284+05:30"
        by_delivery_status.end_time = "2021-01-02T03:05:52.284+05:30"
        by_delivery_status.product_id = "tokenManagement"
        by_delivery_status.event_type = "tms.token.created"
        request_obj.by_delivery_status = by_delivery_status

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ManageWebhooksApi.new(api_client, config)

        data, status_code, headers = api_instance.replay_previous_webhook(webhook_id, request_obj, opts)

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
        Replay_failed_transactions_by_set_start_and_end_time.new.run(webhook_id)
    end
end