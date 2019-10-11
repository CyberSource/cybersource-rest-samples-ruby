require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class RetrieveAvailableReports
    def run()
        start_time = "2018-10-01T00:00:00.0Z"
        end_time = "2018-10-30T23:59:59.0Z"
        time_query_type = "executedTime"

        opts = {}
        opts[:"organization_id"] = nil
        opts[:"report_mime_type"] = "application/xml"
        opts[:"report_frequency"] = nil
        opts[:"report_name"] = nil
        opts[:"report_definition_id"] = nil
        opts[:"report_status"] = nil

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportsApi.new(api_client, config)

        data, status_code, headers = api_instance.search_reports(start_time, end_time, time_query_type, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing query parameter <organizationId>:"
        organizationId = gets.chomp
        puts "\nInput missing query parameter <startTime>:"
        startTime = gets.chomp
        puts "\nInput missing query parameter <endTime>:"
        endTime = gets.chomp
        puts "\nInput missing query parameter <timeQueryType>:"
        timeQueryType = gets.chomp
        puts "\nInput missing query parameter <reportMimeType>:"
        reportMimeType = gets.chomp
        puts "\nInput missing query parameter <reportFrequency>:"
        reportFrequency = gets.chomp
        puts "\nInput missing query parameter <reportName>:"
        reportName = gets.chomp
        puts "\nInput missing query parameter <reportDefinitionId>:"
        reportDefinitionId = gets.chomp
        puts "\nInput missing query parameter <reportStatus>:"
        reportStatus = gets.chomp

        RetrieveAvailableReports.new.run(organizationId, startTime, endTime, timeQueryType, reportMimeType, reportFrequency, reportName, reportDefinitionId, reportStatus)
    end
end
