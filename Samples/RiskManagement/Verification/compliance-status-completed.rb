require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Compliance_status_completed
    def run()
        request_obj = CyberSource::ValidateExportComplianceRequest.new
        client_reference_information = CyberSource::Riskv1addressverificationsClientReferenceInformation.new
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

        export_compliance_information = CyberSource::Riskv1exportcomplianceinquiriesExportComplianceInformation.new
        export_compliance_information.address_operator = "and"
        weights = CyberSource::Riskv1exportcomplianceinquiriesExportComplianceInformationWeights.new
        weights.address = "abc"
        weights.company = "def"
        weights.name = "adb"
        export_compliance_information.weights = weights

        sanction_lists =  []
        sanction_lists << "abc"
        sanction_lists << "acc"
        sanction_lists << "bac"
        export_compliance_information.sanction_lists = sanction_lists
        request_obj.export_compliance_information = export_compliance_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::VerificationApi.new(api_client, config)

        data, status_code, headers = api_instance.validate_export_compliance(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Compliance_status_completed.new.run()
    end
end
