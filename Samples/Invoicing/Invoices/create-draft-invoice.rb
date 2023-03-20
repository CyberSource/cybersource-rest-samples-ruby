require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Create_draft_invoice
    def run()
        request_obj = CyberSource::CreateInvoiceRequest.new
        customer_information = CyberSource::Invoicingv2invoicesCustomerInformation.new
        customer_information.name = "Tanya Lee"
        customer_information.email = "tanya.lee@my-email.world"
        request_obj.customer_information = customer_information

        invoice_information = CyberSource::Invoicingv2invoicesInvoiceInformation.new
        invoice_information.description = "This is a test invoice"
        invoice_information.due_date = "2019-07-11"
        invoice_information.send_immediately = false
        invoice_information.allow_partial_payments = true
        invoice_information.delivery_mode = "none"
        request_obj.invoice_information = invoice_information

        order_information = CyberSource::Invoicingv2invoicesOrderInformation.new
        amount_details = CyberSource::Invoicingv2invoicesOrderInformationAmountDetails.new
        amount_details.total_amount = "2623.64"
        amount_details.currency = "USD"
        amount_details.discount_amount = "126.08"
        amount_details.discount_percent = 5.0
        amount_details.sub_amount = 2749.72
        amount_details.minimum_partial_amount = 20.00
        tax_details = CyberSource::Invoicingv2invoicesOrderInformationAmountDetailsTaxDetails.new
        tax_details.type = "State Tax"
        tax_details.amount = "208.00"
        tax_details.rate = "8.25"
        amount_details.tax_details = tax_details
        freight = CyberSource::Invoicingv2invoicesOrderInformationAmountDetailsFreight.new
        freight.amount = "20.00"
        freight.taxable = true
        amount_details.freight = freight
        order_information.amount_details = amount_details

        line_items = []
        line_items1 = CyberSource::Invoicingv2invoicesOrderInformationLineItems.new
        line_items1.product_sku = "P653727383"
        line_items1.product_name = "First line item's name"
        line_items1.quantity = 21
        line_items1.unit_price = "120.08"
        line_items << line_items1

        order_information.line_items = line_items
        request_obj.order_information = order_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::InvoicesApi.new(api_client, config)

        data, status_code, headers = api_instance.create_invoice(request_obj)

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

        Create_draft_invoice.new.run()
    end
end
