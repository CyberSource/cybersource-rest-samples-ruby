require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Create_search_request
    def run()
        request_obj = CyberSource::CreateSearchRequest.new
        request_obj.save = false
        request_obj.name = "MRN"
        request_obj.timezone = "America/Chicago"
        request_obj.query = "clientReferenceInformation.code:TC50171_3 AND submitTimeUtc:[NOW/DAY-7DAYS TO NOW/DAY+1DAY}"
        request_obj.offset = 0
        request_obj.limit = 100
        request_obj.sort = "id:asc,submitTimeUtc:asc"
        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_search(request_obj)

        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        Create_search_request.new.run()
    end
end
