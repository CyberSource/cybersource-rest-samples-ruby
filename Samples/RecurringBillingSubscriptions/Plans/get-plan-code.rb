require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_plan_code
  def run()
    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PlansApi.new(api_client, config)

    data, status_code, headers = api_instance.get_plan_code()

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
    Get_plan_code.new.run()
  end
end