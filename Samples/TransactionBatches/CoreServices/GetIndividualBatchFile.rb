require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class GetIndividualBatchFile
  def main()
    id = "Owcyk6pl"
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)
    data, status_code, headers = api_instance.get_transaction_batch_id(id)
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  GetIndividualBatchFile.new.main
end


