require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Customer_match_denied_parties_list
    def run()
        request_obj = CyberSource::ValidateExportComplianceRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "verification example"
        client_reference_information.comments = "Export-basic"
        partner = CyberSource::Riskv1decisionsClientReferenceInformationPartner.new
        partner.developer_id = "7891234"
        partner.solution_id = "89012345"
        client_reference_information.partner = partner
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1exportcomplianceinquiriesOrderInformation.new
        bill_to = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationBillTo.new
        bill_to.address1 = "901 Metro Centre Blvd"
        bill_to.administrative_area = "CA"
        bill_to.country = "US"
        bill_to.locality = "Foster City"
        bill_to.postal_code = "94404"
        company = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationBillToCompany.new
        company.name = "A & C International Trade, Inc"
        bill_to.company = company
        bill_to.first_name = "ANDREE"
        bill_to.last_name = "AGNESE"
        bill_to.email = "test@domain.com"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationShipTo.new
        ship_to.country = "IN"
        ship_to.first_name = "DumbelDore"
        ship_to.last_name = "Albus"
        order_information.ship_to = ship_to

        line_items = []
        line_items1 = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationLineItems.new
        line_items1.unit_price = "120.50"
        line_items1.quantity = 3
        line_items1.product_sku = "123456"
        line_items1.product_name = "Qwe"
        line_items1.product_code = "physical_software"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

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
        Customer_match_denied_parties_list.new.run()
    end
end
