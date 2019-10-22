require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class GetPaymentBatchSummaryData
    def run()
        start_time = "2019-05-01T12:00:00-05:00"
        end_time = "2019-08-30T12:00:00-05:00"

        opts = {}
        opts[:"organization_id"] = "testrest"
        opts[:"roll_up"] = nil
        opts[:"breakdown"] = nil
        opts[:"start_day_of_week"] = nil

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentBatchSummariesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_payment_batch_summary(start_time, end_time, opts)

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
        puts "\nInput missing query parameter <rollUp>:"
        rollUp = gets.chomp
        puts "\nInput missing query parameter <breakdown>:"
        breakdown = gets.chomp
        puts "\nInput missing query parameter <startDayOfWeek>:"
        startDayOfWeek = gets.chomp

        GetPaymentBatchSummaryData.new.run(startTime, endTime, organizationId, rollUp, breakdown, startDayOfWeek)
    end
end
