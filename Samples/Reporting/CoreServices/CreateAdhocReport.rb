require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class CreateAdhocReport
  def main()
   puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
   config = MerchantConfiguration.new.merchantConfigProp()
   request= CyberSource::RequestBody1.new
   api_client = CyberSource::ApiClient.new
   api_instance = CyberSource::ReportsApi.new(api_client, config)
   request.report_definition_name = "TransactionRequestClass"
   request.report_fields=[
    "Request.RequestID",
    "Request.TransactionDate",
    "Request.MerchantID"
   ]
   request.report_mime_type="application/xml"
   request.timezone = "GMT"
   request.report_name = "Adhoc_tes v351"
   request.report_start_time = "2018-09-01T12:00:00+05:00"
   request.report_end_time = "2018-09-02T12:00:00+05:00"
   report_pref = {}
   report_pref['SignedAmounts'] = "true"
   report_pref['fieldNameConvention'] = "SOAPI"
   request.report_preferences = report_pref
   puts "\nAPI REQUEST BODY:"
   request_body = api_client.object_to_hash(request)
   puts api_client.maskPayload(request_body.to_json)
   response_body, response_code, response_headers = api_instance.create_report(request)
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
CreateAdhocReport.new.main
end