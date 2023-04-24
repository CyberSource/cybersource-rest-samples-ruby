require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'
require 'csv'

public
class Download_file_with_file_identifier
    def run(file_id)
        download_file_path = "resource//DownloadedFileWithFileID"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SecureFileShareApi.new(api_client, config)

        data, status_code, headers = api_instance.get_file(file_id, opts)

        # START : FILE DOWNLOAD FUNCTIONALITY
        if data != nil
            file_extension = headers['Content-Type']

            if file_extension.include? "json"
                file_extension = file_extension[-4..file_extension.length]
            else
                file_extension = file_extension[-3..file_extension.length]
            end

            download_file_path = download_file_path + "." + file_extension

            file_handle = File.new(download_file_path, "w")
            file_handle.write(data)
            file_handle.close
            puts "File downloaded at the following location : " + File.expand_path(download_file_path)
        end
        # END : FILE DOWNLOAD FUNCTIONALITY

        write_log_audit(status_code)
        return data, status_code, headers
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        file_id = "Q2hhcmdlYmFja0FuZFJldHJpZXZhbFJlcG9ydC1hYWVkMWEwMS03OGNhLTU1YzgtZTA1My1hMjU4OGUwYWNhZWEuY3N2LTIwMjAtMDctMzA="

        Download_file_with_file_identifier.new.run(file_id)
    end
end
