require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Canadian_billing_details
    def run()
        request_obj = CyberSource::VerifyCustomerAddressRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "addressEg"
        client_reference_information.comments = "dav-All fields"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1addressverificationsOrderInformation.new
        bill_to = CyberSource::Riskv1addressverificationsOrderInformationBillTo.new
        bill_to.address1 = "1650 Burton Ave"
        bill_to.address2 = ""
        bill_to.address3 = ""
        bill_to.address4 = ""
        bill_to.administrative_area = "BC"
        bill_to.country = "CA"
        bill_to.locality = "VICTORIA"
        bill_to.postal_code = "V8T 2N6"
        order_information.bill_to = bill_to

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
        Canadian_billing_details.new.run()
    end
end
