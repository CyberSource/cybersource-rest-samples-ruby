require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class No_company_name
    def run()
        request_obj = CyberSource::ValidateExportComplianceRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "verification example"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1exportcomplianceinquiriesOrderInformation.new
        bill_to = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationBillTo.new
        bill_to.address1 = "901 Metro Centre Blvd"
        bill_to.address2 = "2"
        bill_to.administrative_area = "CA"
        bill_to.country = "US"
        bill_to.locality = "Foster City"
        bill_to.postal_code = "94404"
        bill_to.first_name = "Suman"
        bill_to.last_name = "Kumar"
        bill_to.email = "donewithhorizon@test.com"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationShipTo.new
        ship_to.country = "be"
        ship_to.first_name = "DumbelDore"
        ship_to.last_name = "Albus"
        order_information.ship_to = ship_to

        line_items = []
        line_items1 = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationLineItems.new
        line_items1.unit_price = "19.00"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

        buyer_information = CyberSource::Riskv1addressverificationsBuyerInformation.new
        buyer_information.merchant_customer_id = "87789"
        request_obj.buyer_information = buyer_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VerificationApi.new(api_client, config)

        data, status_code, headers = api_instance.validate_export_compliance(request_obj)

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
        No_company_name.new.run()
    end
end
