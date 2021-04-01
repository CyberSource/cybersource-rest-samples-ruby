require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Authorization_with_customer_token_default_payment_instrument_and_shipping_address_creation
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new

        action_list =  []
        action_list << "TOKEN_CREATE"
        processing_information.action_list = action_list

        action_token_types =  []
        action_token_types << "paymentInstrument"
        action_token_types << "shippingAddress"
        processing_information.action_token_types = action_token_types
        processing_information.capture = false
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2031"
        card.security_code = "123"
        payment_information.card = card
        customer = CyberSource::Ptsv2paymentsPaymentInformationCustomer.new
        customer.id = "AB695DA801DD1BB6E05341588E0A3BDC"
        payment_information.customer = customer
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "102.21"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "san francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Ptsv2paymentsOrderInformationShipTo.new
        ship_to.first_name = "John"
        ship_to.last_name = "Doe"
        ship_to.address1 = "1 Market St"
        ship_to.locality = "san francisco"
        ship_to.administrative_area = "CA"
        ship_to.postal_code = "94105"
        ship_to.country = "US"
        order_information.ship_to = ship_to
        request_obj.order_information = order_information

        token_information = CyberSource::Ptsv2paymentsTokenInformation.new
        payment_instrument = CyberSource::Ptsv2paymentsTokenInformationPaymentInstrument.new
        payment_instrument._default = true
        token_information.payment_instrument = payment_instrument
        shipping_address = CyberSource::Ptsv2paymentsTokenInformationShippingAddress.new
        shipping_address._default = true
        token_information.shipping_address = shipping_address
        request_obj.token_information = token_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts data, status_code, headers

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Authorization_with_customer_token_default_payment_instrument_and_shipping_address_creation.new.run()
    end
end
