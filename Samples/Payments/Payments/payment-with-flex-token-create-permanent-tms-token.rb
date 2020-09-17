require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Payment_with_flex_token_create_permanent_tms_token
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
        action_token_types << "customer"
        action_token_types << "paymentInstrument"
        action_token_types << "shippingAddress"
        processing_information.action_token_types = action_token_types
        processing_information.capture = false
        request_obj.processing_information = processing_information

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
        token_information.transient_token_jwt = "eyJraWQiOiIwODVLd3ZiZHVqZW1DZDN3UnNxVFg3RG5nZzlZVk04NiIsImFsZyI6IlJTMjU2In0.eyJkYXRhIjp7Im51bWJlciI6IjQxMTExMVhYWFhYWDExMTEiLCJ0eXBlIjoiMDAxIn0sImlzcyI6IkZsZXgvMDgiLCJleHAiOjE1OTU2MjAxNTQsInR5cGUiOiJtZi0wLjExLjAiLCJpYXQiOjE1OTU2MTkyNTQsImp0aSI6IjFFMTlWWVlBUEFEUllPSzREUUM1NFhRN1hUVTlYN01YSzBCNTc5UFhCUU1HUUExVU1MOFI1RjFCM0IzQTU4MkIifQ.NKSM8zuT9TQC2OIUxIFJQk4HKeHhj_RGWmEqOQhBi0TIynt_kCIup1UVtAlhPzUfPWLwRrUVXnA9dyjLt_Q-pFZnvZ2lVANbiOq_R0us88MkM_mqaELuInCwxFeFZKA4gl8XmDFARgX1aJttC19Le6NYOhK2gpMrV4i0yz-IkbScsk0_vCH3raayNacFU2Wy9xei6H_V0yw2GeOs7kF6wdtMvBNw_uoLXd77LGE3LmV7z1TpJcG1SXy2s0bwYhEvkQGnrq6FfY8w7-UkDBWT1GhU3ZVP4y7h0l1WEX2xqf_ze25ZiYJQfWrEWPBHXRubOpAuaf4rfeZei0mRwPU-sQ"
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

        Payment_with_flex_token_create_permanent_tms_token.new.run()
    end
end
