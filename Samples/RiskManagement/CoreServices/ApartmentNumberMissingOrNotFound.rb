require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class ApartmentNumberMissingOrNotFound
    def run()
        request_obj = CyberSource::VerifyCustomerAddressRequest.new
        client_reference_information = CyberSource::Riskv1addressverificationsClientReferenceInformation.new
        client_reference_information.code = "addressEg"
        client_reference_information.comments = "dav-error response check"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1addressverificationsOrderInformation.new
        bill_to = CyberSource::Riskv1addressverificationsOrderInformationBillTo.new
        bill_to.address1 = "6th 4th ave"
        bill_to.address2 = ""
        bill_to.administrative_area = "NY"
        bill_to.country = "US"
        bill_to.locality = "rensslaer"
        bill_to.postal_code = "12144"
        order_information.bill_to = bill_to

        line_items = []
        line_items1 = CyberSource::Riskv1addressverificationsOrderInformationLineItems.new
        line_items1.unit_price = "120.50"
        line_items1.quantity = 3
        line_items1.product_sku = "996633"
        line_items1.product_name = "qwerty"
        line_items1.product_code = "handling"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VerificationApi.new(api_client, config)

        data, status_code, headers = api_instance.verify_customer_address(request_obj)

        puts data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        ApartmentNumberMissingOrNotFound.new.run()
    end
end
