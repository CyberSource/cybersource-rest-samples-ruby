require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Get_list_of_plans
  def run()
    offset = 0
    limit = 10
    code = nil
    status = nil
    name = nil

    opts = {}
    opts[:'offset'] = offset unless offset == 0
    opts[:'limit'] = limit unless limit == 0
    opts[:'code'] = code unless code.nil?
    opts[:'status'] = status unless status.nil?
    opts[:'name'] = name unless name.nil?

    config = MerchantConfiguration.new.merchantConfigProp()
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::PlansApi.new(api_client, config)

    data, status_code, headers = api_instance.get_plans(opts)

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
    Get_list_of_plans.new.run()
  end
end