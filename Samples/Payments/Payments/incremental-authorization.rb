require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'
require_relative './authorization-for-incremental-authorization-flow.rb'

public
class Incremental_authorization
    def run()
        id = (JSON.parse(Authorization_for_incremental_authorization_flow.new.run()))['id']
        request_obj = CyberSource::IncrementAuthRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsidClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsidProcessingInformation.new
        authorization_options = CyberSource::Ptsv2paymentsidProcessingInformationAuthorizationOptions.new
        initiator = CyberSource::Ptsv2paymentsidProcessingInformationAuthorizationOptionsInitiator.new
        initiator.stored_credential_used = true
        authorization_options.initiator = initiator
        processing_information.authorization_options = authorization_options
        request_obj.processing_information = processing_information

        order_information = CyberSource::Ptsv2paymentsidOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidOrderInformationAmountDetails.new
        amount_details.additional_amount = "22.49"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsidMerchantInformation.new
        merchant_information.transaction_local_date_time = "20191002080000"
        request_obj.merchant_information = merchant_information

        travel_information = CyberSource::Ptsv2paymentsidTravelInformation.new
        travel_information.duration = "4"
        request_obj.travel_information = travel_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.increment_auth(id, request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Incremental_authorization.new.run()
    end
end
