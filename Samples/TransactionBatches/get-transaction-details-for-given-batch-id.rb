require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class Get_transaction_details_for_given_batch_id
    def run(id)
        download_file_path = "resource//BatchDetailsReport"

        opts = {}
        opts[:"upload_date"] = "2019-08-30"
        opts[:"status"] = "Rejected"

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::TransactionBatchesApi.new(api_client, config)

        data, status_code, headers = api_instance.get_transaction_batch_details(id, opts)

        # START : FILE DOWNLOAD FUNCTIONALITY
        if data != nil
            file_extension = headers['Content-Type']

            if file_extension.include? "json"
                file_extension = file_extension[-4..file_extension.length]
            else
                file_extension = file_extension[-3..file_extension.length]
            end

            download_file_path = download_file_path + "." + file_extension

            file_handle = File.new(download_file_path, "w")
            file_handle.write(data)
            file_handle.close
            puts "File downloaded at the following location : " + File.expand_path(download_file_path)
        end
        # END : FILE DOWNLOAD FUNCTIONALITY

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0
        id = "20190110"

        Get_transaction_details_for_given_batch_id.new.run(id)
    end
end
