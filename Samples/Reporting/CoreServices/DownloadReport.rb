require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require 'csv'

public
class DownloadReport
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    file_path = "..\\cybersource-rest-samples-ruby\\resource\\DownloadReport.xml"
    config = MerchantConfiguration.new.merchantConfigProp()
    reportDate = "2018-09-02"
    reportName = "Adhoc_report_test_v12"
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::ReportDownloadsApi.new(api_client, config)
    opts = {}
    opts[:'organization_id'] = "testrest"

    response_body, response_code, response_headers = api_instance.download_report(reportDate, reportName, opts)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
    # Writing Response to XML file
    if response_body != nil
      f = File.new(file_path,"w")
      f.write(response_body)
      f.close
      puts "File downloaded at the below location:\n" + File.expand_path(file_path)
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
  DownloadReport.new.main
end


