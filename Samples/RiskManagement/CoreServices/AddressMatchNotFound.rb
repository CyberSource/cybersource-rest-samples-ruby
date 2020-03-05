require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class AddressMatchNotFound
    def run()
        request_obj = CyberSource::VerifyCustomerAddressRequest.new
        client_reference_information = CyberSource::Riskv1addressverificationsClientReferenceInformation.new
        client_reference_information.code = "addressEg"
        client_reference_information.comments = "dav-error response check"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1addressverificationsOrderInformation.new
        bill_to = CyberSource::Riskv1addressverificationsOrderInformationBillTo.new
        bill_to.address1 = "Apt C "
        bill_to.address2 = ""
        bill_to.administrative_area = "CA"
        bill_to.country = "US"
        bill_to.locality = "Glendale"
        bill_to.postal_code = "91204"
        order_information.bill_to = bill_to
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

        AddressMatchNotFound.new.run()
    end
end
