require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Replay_specific_list_of_transactions
    def run(webhook_id)
        request_obj = CyberSource::ReplayWebhooksRequest.new

        by_transaction_trace_identifiers =  []
        by_transaction_trace_identifiers << "1f1d0bf4-9299-418d-99d8-faa3313829f1"
        by_transaction_trace_identifiers << "d19fb205-20e5-43a2-867e-bd0f574b771e"
        by_transaction_trace_identifiers << "2f2461a3-457c-40e9-867f-aced89662bbb"
        by_transaction_trace_identifiers << "e23ddc19-93d5-4f1f-8482-d7cafbb3ed9b"
        by_transaction_trace_identifiers << "eb9fc4a9-b31f-48d5-81a9-b1d773fd76d8"
        request_obj.by_transaction_trace_identifiers = by_transaction_trace_identifiers
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
        Replay_specific_list_of_transactions.new.run(webhook_id)
    end
end