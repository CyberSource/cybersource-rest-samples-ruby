require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class authorization_with_decision_manager_device_information
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "54323007"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4444444444444448"
        card.expiration_month = "12"
        card.expiration_year = "2020"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "144.14"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "James"
        bill_to.last_name = "Smith"
        bill_to.address1 = "96, powers street"
        bill_to.locality = "Clearwater milford"
        bill_to.administrative_area = "NH"
        bill_to.postal_code = "03055"
        bill_to.country = "US"
        bill_to.email = "test@visa.com"
        bill_to.phone_number = "7606160717"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        device_information = CyberSource::Ptsv2paymentsDeviceInformation.new
        device_information.host_name = "host.com"
        device_information.ip_address = "64.124.61.215"
        device_information.user_agent = "Chrome"
        device_information.http_browser_email = "xyz@gmail.com"
        request_obj.device_information = device_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        authorization_with_decision_manager_device_information.new.run()
    end
end
