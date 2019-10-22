require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetConversionDetailTransactions
    def run()
        start_time = "2019-03-21T00:00:00.0Z"
        end_time = "2019-03-21T23:00:00.0Z"

        opts = {}
        opts[:"organization_id"] = "testrest"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ConversionDetailsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_conversion_detail(start_time, end_time, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        puts "\nInput missing query parameter <startTime>:"
        startTime = gets.chomp
        puts "\nInput missing query parameter <endTime>:"
        endTime = gets.chomp
        puts "\nInput missing query parameter <organizationId>:"
        organizationId = gets.chomp

        GetConversionDetailTransactions.new.run(startTime, endTime, organizationId)
    end
end
