require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require 'csv'

public
class Download_report
    def run()
        download_file_path = "resource//DownloadedReport"
        report_date = "2020-03-03"
        report_name = "testrest_subcription_v2989"

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"report_time"] = "00:00:00Z"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportDownloadsApi.new(api_client, config)

        data, status_code, headers = api_instance.download_report(report_date, report_name, opts)

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

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Download_report.new.run()
    end
end
