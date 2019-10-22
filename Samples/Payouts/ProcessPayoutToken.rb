require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class ProcessPayoutToken
    def run()
        request_obj = CyberSource::OctCreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2payoutsClientReferenceInformation.new
        client_reference_information.code = "111111113"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Ptsv2payoutsOrderInformation.new
        amount_details = CyberSource::Ptsv2payoutsOrderInformationAmountDetails.new
        amount_details.total_amount = "111.00"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2payoutsMerchantInformation.new
        merchant_descriptor = CyberSource::Ptsv2payoutsMerchantInformationMerchantDescriptor.new
        merchant_descriptor.name = "Sending Company Name"
        merchant_descriptor.locality = "FC"
        merchant_descriptor.country = "US"
        merchant_descriptor.administrative_area = "CA"
        merchant_descriptor.postal_code = "94440"
        merchant_information.merchant_descriptor = merchant_descriptor
        request_obj.merchant_information = merchant_information

        recipient_information = CyberSource::Ptsv2payoutsRecipientInformation.new
        recipient_information.first_name = "John"
        recipient_information.last_name = "Doe"
        recipient_information.address1 = "Paseo Padre Boulevard"
        recipient_information.locality = "Foster City"
        recipient_information.administrative_area = "CA"
        recipient_information.country = "US"
        recipient_information.postal_code = "94400"
        recipient_information.phone_number = "6504320556"
        request_obj.recipient_information = recipient_information

        sender_information = CyberSource::Ptsv2payoutsSenderInformation.new
        sender_information.reference_number = "1234567890"
        account = CyberSource::Ptsv2payoutsSenderInformationAccount.new
        account.funds_source = "05"
        account.number = "1234567890123456789012345678901234"
        sender_information.account = account
        sender_information.name = "Company Name"
        sender_information.address1 = "900 Metro Center Blvd.900"
        sender_information.locality = "Foster City"
        sender_information.administrative_area = "CA"
        sender_information.country_code = "US"
        request_obj.sender_information = sender_information

        processing_information = CyberSource::Ptsv2payoutsProcessingInformation.new
        processing_information.business_application_id = "FD"
        processing_information.network_routing_order = "V8"
        processing_information.commerce_indicator = "internet"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2payoutsPaymentInformation.new
        customer = CyberSource::Ptsv2paymentsPaymentInformationCustomer.new
        customer.customer_id = "7500BB199B4270EFE05340588D0AFCAD"
        payment_information.customer = customer
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PayoutsApi.new(api_client, config)

        data, status_code, headers = api_instance.oct_create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        ProcessPayoutToken.new.run()
    end
end
