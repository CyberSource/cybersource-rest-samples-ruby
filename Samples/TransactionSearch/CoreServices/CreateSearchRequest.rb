require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class CreateSearchRequest
  def main()
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::CreateSearchRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::SearchTransactionsApi.new(api_client, config)
    request.save = "false"
    request.name = "MRN"
    request.timezone = "America/Chicago"
    request.query = "clientReferenceInformation.code:TC50171_3 AND submitTimeUtc:[NOW/DAY-7DAYS TO NOW/DAY+1DAY}"
    request.offset = 0
    request.limit = 10
    request.sort = "id:asc,submitTimeUtc:asc"
    data, status_code, headers = api_instance.create_search(request)
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  CreateSearchRequest.new.main
end

