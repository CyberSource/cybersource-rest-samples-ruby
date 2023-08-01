require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_plan
    def run()
        # Required to make the sample code activate-plan.rb work
        plan_information_status = "DRAFT"
        request_obj = CyberSource::CreatePlanRequest.new
        plan_information = CyberSource::Rbsv1plansPlanInformation.new
        plan_information.name = "Gold Plan"
        plan_information.description = "New Gold Plan"
        plan_information.status = plan_information_status
        billing_period = CyberSource::InlineResponse200PlanInformationBillingPeriod.new
        billing_period.length = "1"
        billing_period.unit = "M"
        plan_information.billing_period = billing_period
        billing_cycles = CyberSource::Rbsv1plansPlanInformationBillingCycles.new
        billing_cycles.total = "12"
        plan_information.billing_cycles = billing_cycles
        request_obj.plan_information = plan_information

        order_information = CyberSource::Rbsv1plansOrderInformation.new
        amount_details = CyberSource::Rbsv1plansOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.billing_amount = "10"
        amount_details.setup_fee = "2"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PlansApi.new(api_client, config)

        data, status_code, headers = api_instance.create_plan(request_obj)

        puts status_code, headers, data

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
        Create_plan.new.run()
    end
end