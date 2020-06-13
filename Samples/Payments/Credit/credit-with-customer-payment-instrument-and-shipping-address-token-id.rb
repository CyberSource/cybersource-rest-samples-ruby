require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Credit_with_customer_payment_instrument_and_shipping_address_token_id
    def run()
        request_obj = CyberSource::CreateCreditRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "12345678"
        request_obj.client_reference_information = client_reference_information

        payment_information = CyberSource::Ptsv2paymentsidrefundsPaymentInformation.new
        customer = CyberSource::Ptsv2paymentsPaymentInformationCustomer.new
        customer.id = "7500BB199B4270EFE05340588D0AFCAD"
        payment_information.customer = customer
        payment_instrument = CyberSource::Ptsv2paymentsPaymentInformationPaymentInstrument.new
        payment_instrument.id = "7500BB199B4270EFE05340588D0AFCPI"
        payment_information.payment_instrument = payment_instrument
        shipping_address = CyberSource::Ptsv2paymentsPaymentInformationShippingAddress.new
        shipping_address.id = "7500BB199B4270EFE05340588D0AFCSA"
        payment_information.shipping_address = shipping_address
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsidrefundsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsidcapturesOrderInformationAmountDetails.new
        amount_details.total_amount = "200"
        amount_details.currency = "usd"
        order_information.amount_details = amount_details
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::CreditApi.new(api_client, config)

        data, status_code, headers = api_instance.create_credit(request_obj)

        puts status_code, headers, data

        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        Credit_with_customer_payment_instrument_and_shipping_address_token_id.new.run()
    end
end
