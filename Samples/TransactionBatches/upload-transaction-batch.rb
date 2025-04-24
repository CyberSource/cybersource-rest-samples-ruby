require 'cybersource_rest_client'
require_relative '../../data/ConfigurationForBatchUpload.rb'

public
class Upload_transaction_batch
  def run()
    opts = {}
    file_to_upload = 'resource/qaebc2.rgdltnd0.csv'

    config = ConfigurationForBatchUpload.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

    data, status_code, headers = api_instance.upload_transaction_batch(file_to_upload)

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
    Upload_transaction_batch.new.run()
  end
end
