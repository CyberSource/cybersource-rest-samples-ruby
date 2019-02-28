require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class GetAllSubscriptions
  def main()
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)
    data, status_code, headers = api_instance.get_all_subscriptions()
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  GetAllSubscriptions.new.main
end


