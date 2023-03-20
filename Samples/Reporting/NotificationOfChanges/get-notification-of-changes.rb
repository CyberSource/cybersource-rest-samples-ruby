require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_notification_of_changes
    def run()
        start_time = "2021-10-01T12:00:00Z"
        end_time = "2021-10-10T12:00:00Z"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::NotificationOfChangesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_notification_of_change_report(start_time, end_time)

        puts data, status_code, headers
        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Get_notification_of_changes.new.run()
    end
end
