require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Bin_lookup_with_tms_customer_id
    def run()
        request_obj = CyberSource::CreateBinLookupRequest.new
        payment_information = CyberSource::Binv1binlookupPaymentInformation.new
        customer = CyberSource::GetAllSubscriptionsResponsePaymentInformationCustomer.new
        customer.id = "E5426CFDE77F7390E053A2598D0A925D"
        payment_information.customer = customer
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::BinLookupApi.new(api_client, config)

        data, status_code, headers = api_instance.get_account_info(request_obj)

        puts status_code, headers, data

        write_log_audit(status_code)
        return data, status_code, headers
    rescue StandardError => err
        write_log_audit(err.code)
        puts err.message
    end

    def write_log_audit(status)
        filename = ($0.split("/")).last.split(".")[0]
        puts "[Sample Code Testing] [#{filename}] #{status}"
    end

    if __FILE__ == $0
        Bin_lookup_with_tms_customer_id.new.run()
    end
end