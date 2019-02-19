require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class CreateReportSubscriptionForReportNameByOrganization
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    config = MerchantConfiguration.new.merchantConfigProp()
    request= CyberSource::RequestBody.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)
    request.report_definition_name="TransactionRequestClass"
    request.report_fields=[
            "Request.RequestID",
            "Request.TransactionDate",
            "Request.MerchantID"
    ]
    request.report_mime_type="text/csv"
    request.report_name = "report_v1_test"
    request.report_frequency="WEEKLY"
    request.timezone="America/Chicago"
    request.start_time="0406"
    request.start_day=1
    puts "\nAPI REQUEST BODY:"
    request_body = api_client.object_to_hash(request)
    puts api_client.maskPayload(request_body.to_json)
    response_body, response_code, response_headers = api_instance.create_subscription(request)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
    if(response_code == 201)
      require_relative './DeleteSubscriptionOfReportNameByOrganization.rb'
      DeleteSubscriptionOfReportNameByOrganization.new.main(request.report_name)
    end
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
  if __FILE__ == $0
    CreateReportSubscriptionForReportNameByOrganization.new.main
  end
end
