require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class GetNotificationOfChanges
  def main()
    config = MerchantConfiguration.new.merchantConfigProp()
    start_time = "2019-05-01T12:00:00-05:00"
    end_time = "2019-06-30T12:00:00-05:00"
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::NotificationOfChangesApi.new(api_client, config)
    data, status_code, headers = api_instance.get_notification_of_change_report(start_time, end_time)
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  GetNotificationOfChanges.new.main
end


