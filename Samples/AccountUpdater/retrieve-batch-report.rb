require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Retrieve_batch_report
    def run()
        batch_id = "16188390061150001062041064"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::BatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_batch_report(batch_id)

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
        Retrieve_batch_report.new.run()
    end
end
