require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Multiple_sanction_lists
    def run()
        request_obj = CyberSource::ValidateExportComplianceRequest.new
        client_reference_information = CyberSource::Riskv1decisionsClientReferenceInformation.new
        client_reference_information.code = "verification example"
        client_reference_information.comments = "All fields"
        request_obj.client_reference_information = client_reference_information

        order_information = CyberSource::Riskv1exportcomplianceinquiriesOrderInformation.new
        bill_to = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationBillTo.new
        bill_to.address1 = "901 Metro Centre Blvd"
        bill_to.address2 = " "
        bill_to.address3 = ""
        bill_to.address4 = "Foster City"
        bill_to.administrative_area = "NH"
        bill_to.country = "US"
        bill_to.locality = "CA"
        bill_to.postal_code = "03055"
        company = CyberSource::Riskv1exportcomplianceinquiriesOrderInformationBillToCompany.new
        company.name = "A & C International Trade, Inc."
        bill_to.company = company
        bill_to.first_name = "Suman"
        bill_to.last_name = "Kumar"
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
        line_items1.product_sku = "610009"
        line_items1.product_name = "Xer"
        line_items1.product_code = "physical_software"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

        buyer_information = CyberSource::Riskv1addressverificationsBuyerInformation.new
        buyer_information.merchant_customer_id = "Export1"
        request_obj.buyer_information = buyer_information

        device_information = CyberSource::Riskv1exportcomplianceinquiriesDeviceInformation.new
        device_information.ip_address = "127.0.0.1"
        device_information.host_name = "www.cybersource.ir"
        request_obj.device_information = device_information

        export_compliance_information = CyberSource::Riskv1exportcomplianceinquiriesExportComplianceInformation.new
        export_compliance_information.address_operator = "and"
        weights = CyberSource::Ptsv2paymentsWatchlistScreeningInformationWeights.new
        weights.address = "low"
        weights.company = "exact"
        weights.name = "exact"
        export_compliance_information.weights = weights

        sanction_lists =  []
        sanction_lists << "Bureau Of Industry and Security"
        sanction_lists << "DOS_DTC"
        sanction_lists << "AUSTRALIA"
        export_compliance_information.sanction_lists = sanction_lists
        request_obj.export_compliance_information = export_compliance_information

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
        Multiple_sanction_lists.new.run()
    end
end
