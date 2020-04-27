require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class get_notification_of_changes
    def run()
        start_time = "2019-09-01T12:00:00Z"
        end_time = "2019-09-10T12:00:00Z"

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::NotificationOfChangesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_notification_of_change_report(start_time, end_time)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        get_notification_of_changes.new.run()
    end
end
