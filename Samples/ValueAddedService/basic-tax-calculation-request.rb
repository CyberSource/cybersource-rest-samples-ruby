require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Basic_tax_calculation_request
    def run()
        request_obj = CyberSource::TaxRequest.new
        client_reference_information = CyberSource::Vasv2taxClientReferenceInformation.new
        client_reference_information.code = "TAX_TC001"
        request_obj.client_reference_information = client_reference_information

        tax_information = CyberSource::Vasv2taxTaxInformation.new
        tax_information.show_tax_per_line_item = "Yes"
        request_obj.tax_information = tax_information

        order_information = CyberSource::Vasv2taxOrderInformation.new
        amount_details = CyberSource::RiskV1DecisionsPost201ResponseOrderInformationAmountDetails.new
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Vasv2taxOrderInformationBillTo.new
        bill_to.address1 = "1 Market St"
        bill_to.locality = "San Francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        order_information.bill_to = bill_to

        line_items = []
        line_items1 = CyberSource::Vasv2taxOrderInformationLineItems.new
        line_items1.product_sku = "07-12-00657"
        line_items1.product_code = "50161815"
        line_items1.quantity = 1
        line_items1.product_name = "Chewing Gum"
        line_items1.unit_price = "1200"
        line_items << line_items1

        line_items2 = CyberSource::Vasv2taxOrderInformationLineItems.new
        line_items2.product_sku = "07-12-00659"
        line_items2.product_code = "50181905"
        line_items2.quantity = 1
        line_items2.product_name = "Sugar Cookies"
        line_items2.unit_price = "1240"
        line_items << line_items2

        line_items3 = CyberSource::Vasv2taxOrderInformationLineItems.new
        line_items3.product_sku = "07-12-00658"
        line_items3.product_code = "5020.11"
        line_items3.quantity = 1
        line_items3.product_name = "Carbonated Water"
        line_items3.unit_price = "9001"
        line_items << line_items3

        order_information.line_items = line_items
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TaxesApi.new(api_client, config)

        data, status_code, headers = api_instance.calculate_tax(request_obj)

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
        Basic_tax_calculation_request.new.run()
    end
end
