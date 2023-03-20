require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Shipping_details_not_us_or_canada
    def run()
        request_obj = CyberSource::VerifyCustomerAddressRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "addressEg"
        client_reference_information.comments = "dav-All fields"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1addressverificationsOrderInformation.new
        bill_to = CyberSource::Riskv1addressverificationsOrderInformationBillTo.new
        bill_to.address1 = "12301 research st"
        bill_to.address2 = "1"
        bill_to.address3 = "2"
        bill_to.address4 = "3"
        bill_to.administrative_area = "TX"
        bill_to.country = "US"
        bill_to.locality = "Austin"
        bill_to.postal_code = "78759"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Riskv1addressverificationsOrderInformationShipTo.new
        ship_to.address1 = "4R.ILHA TERCEIRA,232-R/C-ESQ"
        ship_to.address2 = " "
        ship_to.address3 = ""
        ship_to.address4 = ""
        ship_to.administrative_area = "WI"
        ship_to.country = "PT"
        ship_to.locality = "Carcavelos"
        ship_to.postal_code = "29681"
        order_information.ship_to = ship_to

        line_items = []
        line_items1 = CyberSource::Riskv1addressverificationsOrderInformationLineItems.new
        line_items1.unit_price = "120.50"
        line_items1.quantity = 3
        line_items1.product_sku = "9966223"
        line_items1.product_name = "headset"
        line_items1.product_code = "electronic"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

        buyer_information = CyberSource::Riskv1addressverificationsBuyerInformation.new
        buyer_information.merchant_customer_id = "ABCD"
        request_obj.buyer_information = buyer_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VerificationApi.new(api_client, config)

        data, status_code, headers = api_instance.verify_customer_address(request_obj)

        puts data, status_code, headers
        write_log_audit(status_code)
        return data
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Shipping_details_not_us_or_canada.new.run()
    end
end
