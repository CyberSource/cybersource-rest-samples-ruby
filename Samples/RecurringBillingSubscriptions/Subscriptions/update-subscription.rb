require 'cybersource_rest_client'
require_relative '../Subscriptions/create-subscription.rb'
require_relative '../../../data/Configuration.rb'

public
class Update_subscription
    def run()
        id = (JSON.parse(Create_subscription.new.run()[0]))['id']
        request_obj = CyberSource::UpdateSubscription.new
        client_reference_information = CyberSource::Rbsv1subscriptionsClientReferenceInformation.new
        client_reference_information.code = "APGHU"
        partner = CyberSource::Rbsv1subscriptionsClientReferenceInformationPartner.new
        partner.developer_id = "ABCD1234"
        partner.solution_id = "GEF1234"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Rbsv1subscriptionsProcessingInformation.new
        authorization_options = CyberSource::Rbsv1subscriptionsProcessingInformationAuthorizationOptions.new
        initiator = CyberSource::Rbsv1subscriptionsProcessingInformationAuthorizationOptionsInitiator.new
        initiator.type = "merchant"
        authorization_options.initiator = initiator
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        subscription_information = CyberSource::Rbsv1subscriptionsidSubscriptionInformation.new
        subscription_information.plan_id = "424242442"
        subscription_information.name = "Gold subs"
        subscription_information.start_date = "2024-06-15"
        request_obj.subscription_information = subscription_information

        order_information = CyberSource::Rbsv1subscriptionsidOrderInformation.new
        amount_details = CyberSource::Rbsv1subscriptionsidOrderInformationAmountDetails.new
        amount_details.billing_amount = "10"
        amount_details.setup_fee = "5"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.update_subscription(id, request_obj)

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
        Update_subscription.new.run()
    end
end