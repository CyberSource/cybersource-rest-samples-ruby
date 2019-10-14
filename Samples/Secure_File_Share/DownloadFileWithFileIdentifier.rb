require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class DownloadFileWithFileIdentifier
    def run(file_id)

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SecureFileShareApi.new(api_client, config)

        data, status_code, headers = api_instance.get_file(file_id, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing path parameter <fileId>:"
        fileId = gets.chomp

        DownloadFileWithFileIdentifier.new.run(fileId)
    end
end
