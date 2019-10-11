require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetNetfundingInformationForAccountOrMerchant
    def run()
        start_time = "2019-08-01T00:00:00.000Z"
        end_time = "2019-09-01T23:59:59.999Z"

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"group_name"] = nil

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::NetFundingsApi.new(api_client, config)

        data, status_code, headers = api_instance.get_net_funding_details(start_time, end_time, opts)

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
        puts "\nInput missing query parameter <groupName>:"
        groupName = gets.chomp

        GetNetfundingInformationForAccountOrMerchant.new.run(startTime, endTime, organizationId, groupName)
    end
end
