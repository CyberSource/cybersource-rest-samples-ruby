require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class GetNotificationOfChanges
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    start_time = "2018-05-01T12:00:00-05:00"
    end_time = "2018-05-30T12:00:00-05:00"
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::NotificationOfChangesApi.new(api_client, config)
    response_body, response_code, response_headers = api_instance.get_notification_of_change_report(start_time, end_time)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
  rescue StandardError => err
    if (err.respond_to? :response_headers) || (err.respond_to? :response_body) || (err.respond_to? :code)
      puts "\nAPI REQUEST HEADERS:"
      puts api_client.request_headers
      puts "\nAPI RESPONSE CODE: \n#{err.code}", "\nAPI RESPONSE HEADERS: \n#{err.response_headers}", "\nAPI RESPONSE BODY: \n#{err.response_body}"
    else
      puts err.message
    end
  ensure
    puts "\n[END] REQUEST & RESPONSE OF: #{self.class.name}"
  end
  GetNotificationOfChanges.new.main
end


