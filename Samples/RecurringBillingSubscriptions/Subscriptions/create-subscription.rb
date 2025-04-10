require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_subscription
    def run()
        request_obj = CyberSource::CreateSubscriptionRequest.new
        client_reference_information = CyberSource::Rbsv1subscriptionsClientReferenceInformation.new
        client_reference_information.code = "TC501713"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "ABCD1234"
        partner.solution_id = "GEF1234"
        client_reference_information.partner = partner
        client_reference_information.application_name = "CYBS-SDK"
        client_reference_information.application_version = "v1"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Rbsv1subscriptionsProcessingInformation.new
        processing_information.commerce_indicator = "recurring"
        authorization_options = CyberSource::Rbsv1subscriptionsProcessingInformationAuthorizationOptions.new
        initiator = CyberSource::Rbsv1subscriptionsProcessingInformationAuthorizationOptionsInitiator.new
        initiator.type = "merchant"
        authorization_options.initiator = initiator
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        subscription_information = CyberSource::Rbsv1subscriptionsSubscriptionInformation.new
        subscription_information.plan_id = "6868912495476705603955"
        subscription_information.name = "Subscription with PlanId"
        subscription_information.start_date = "2025-06-11"
        request_obj.subscription_information = subscription_information

        payment_information = CyberSource::Rbsv1subscriptionsPaymentInformation.new
        customer = CyberSource::Rbsv1subscriptionsPaymentInformationCustomer.new
        customer.id = "C24F5921EB870D99E053AF598E0A4105"
        payment_information.customer = customer
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_subscription(request_obj)

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
        Create_subscription.new.run()
    end
end