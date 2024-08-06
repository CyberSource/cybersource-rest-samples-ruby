require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Bin_lookup_with_tms_jti_transient_token
    def run()
        request_obj = CyberSource::CreateBinLookupRequest.new
        token_information = CyberSource::Binv1binlookupTokenInformation.new
        token_information.jti = "1E0WC1GO87JG1BDP0CQ8SCR1TTK86U9N98H3WH8IFM9MVEWTIYFI62F4941E7A92"
        request_obj.token_information = token_information

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
        Bin_lookup_with_tms_jti_transient_token.new.run()
    end
end