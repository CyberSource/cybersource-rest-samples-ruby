require 'cybersource_rest_client'
require_relative '../Plans/create-plan.rb'
require_relative '../../../data/Configuration.rb'

public
class Update_plan
    def run()
        id = (JSON.parse(Create_plan.new.run()[0]))['id']
        request_obj = CyberSource::UpdatePlanRequest.new
        plan_information = CyberSource::Rbsv1plansidPlanInformation.new
        plan_information.name = "Gold Plan NA"
        plan_information.description = "Updated Gold Plan"
        billing_period = CyberSource::GetAllPlansResponsePlanInformationBillingPeriod.new
        billing_period.length = "2"
        billing_period.unit = "W"
        plan_information.billing_period = billing_period
        billing_cycles = CyberSource::Rbsv1plansPlanInformationBillingCycles.new
        billing_cycles.total = "11"
        plan_information.billing_cycles = billing_cycles
        request_obj.plan_information = plan_information

        processing_information = CyberSource::Rbsv1plansidProcessingInformation.new
        subscription_billing_options = CyberSource::Rbsv1plansidProcessingInformationSubscriptionBillingOptions.new
        subscription_billing_options.apply_to = "ALL"
        processing_information.subscription_billing_options = subscription_billing_options
        request_obj.processing_information = processing_information

        order_information = CyberSource::GetAllPlansResponseOrderInformation.new
        amount_details = CyberSource::GetAllPlansResponseOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        amount_details.billing_amount = "11"
        amount_details.setup_fee = "2"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PlansApi.new(api_client, config)

        data, status_code, headers = api_instance.update_plan(id, request_obj)

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
        Update_plan.new.run()
    end
end