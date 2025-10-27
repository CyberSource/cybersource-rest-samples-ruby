require 'cybersource_rest_client'
require_relative '../../data/BankAccountValidationConfiguration.rb'

public
class Bank_account_validation
    def run()
        request_obj = CyberSource::AccountValidationsRequest.new
        client_reference_information = CyberSource::Bavsv1accountvalidationsClientReferenceInformation.new
        client_reference_information.code = "TC50171_100"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Bavsv1accountvalidationsProcessingInformation.new
        processing_information.validation_level = 1
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Bavsv1accountvalidationsPaymentInformation.new
        bank = CyberSource::Bavsv1accountvalidationsPaymentInformationBank.new
        bank.routing_number = "041210163"
        account = CyberSource::Bavsv1accountvalidationsPaymentInformationBankAccount.new
        account.number = "99970"
        bank.account = account
        payment_information.bank = bank
        request_obj.payment_information = payment_information

        config = MerchantConfiguration.bankAccountValidationConfiguration()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::BankAccountValidationApi.new(api_client, config)

        data, status_code, headers = api_instance.bank_account_validation_request(request_obj)

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
        Bank_account_validation.new.run()
    end
end