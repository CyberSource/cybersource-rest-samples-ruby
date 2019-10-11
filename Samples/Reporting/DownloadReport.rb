require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class DownloadReport
    def run()
        report_date = "2018-09-30"
        report_name = "Demo_Report"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportDownloadsApi.new(api_client, config)

        data, status_code, headers = api_instance.download_report(report_date, report_name, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        DownloadReport.new.run()
    end
end
