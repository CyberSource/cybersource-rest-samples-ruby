require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class List_batches
    def run()

        offset = 0
        limit = 10
        from_date = '20230101T123000Z'
        to_date = '20230410T123000Z'
        opts = {}
        opts[:"offset"] = offset
        opts = {}
        opts[:"limit"] = limit
        opts = {}
        opts[:"from_date"] = from_date
        opts = {}
        opts[:"to_date"] = to_date

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::BatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_batches_list(opts)

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
        List_batches.new.run()
    end
end
