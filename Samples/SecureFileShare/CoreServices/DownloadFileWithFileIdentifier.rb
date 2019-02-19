require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class DownloadFileWithFileIdentifier
  def main()
    puts "\n[BEGIN] REQUEST & RESPONSE OF: #{self.class.name}"
    file_path = "..\\cybersource-rest-samples-ruby\\resource\\DownloadFileWithFileIdentifier.csv"
    config = MerchantConfiguration.new.merchantConfigProp()
    file_id = "VFJSUmVwb3J0LTc4NTVkMTNmLTkzOTgtNTExMy1lMDUzLWEyNTg4ZTBhNzE5Mi5jc3YtMjAxOC0xMC0yMA=="
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::SecureFileShareApi.new(api_client, config)
    opts = {}
    opts[:'organization_id'] = "testrest"
    response_body, response_code, response_headers = api_instance.get_file(file_id, opts)
    puts "\nAPI REQUEST HEADERS:"
    puts api_client.request_headers
    puts "\nAPI RESPONSE CODE:"
    puts response_code
    puts "\nAPI RESPONSE HEADERS:"
    puts response_headers
    puts "\nAPI RESPONSE BODY:"
    puts response_body
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
      puts err.backtrace
    end
  ensure
    puts "\n[END] REQUEST & RESPONSE OF: #{self.class.name}"
  end
  DownloadFileWithFileIdentifier.new.main
end


