require 'cybersource_rest_client'
require_relative '../../data/ConfigurationWithMLE.rb'

public
class Acp_api_example
    def run()
        request_obj = CyberSource::AgenticCardEnrollmentRequest.new
        request_obj.client_correlation_id = "3e1b7943-6567-4965-a32b-5aa93d057d35"
        device_information = CyberSource::Acpv1tokensDeviceInformation.new
        device_information.user_agent = "SampleUserAgent"
        device_information.application_name = "My Magic App"
        device_information.fingerprint_session_id = "finSessionId"
        device_information.country = "US"
        device_data = CyberSource::Acpv1tokensDeviceInformationDeviceData.new
        device_data.type = "Mobile"
        device_data.manufacturer = "Apple"
        device_data.brand = "Apple"
        device_data.model = "iPhone 16 Pro Max"
        device_information.device_data = device_data
        device_information.ip_address = "192.168.0.100"
        device_information.client_device_id = "000b2767814e4416999f4ee2b099491d2087"
        request_obj.device_information = device_information

        buyer_information = CyberSource::Acpv1tokensBuyerInformation.new
        buyer_information.language = "en"
        buyer_information.merchant_customer_id = "3e1b7943-6567-4965-a32b-5aa93d057d35"

        personal_identification = []
        personal_identification1 = CyberSource::Acpv1tokensBuyerInformationPersonalIdentification.new
        personal_identification1.type = "The identification type"
        personal_identification1.id = "1"
        personal_identification << personal_identification1

        buyer_information.personal_identification = personal_identification
        request_obj.buyer_information = buyer_information

        bill_to = CyberSource::Acpv1tokensBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.full_name = "John Michael Doe"
        bill_to.email = "john.doe@example.com"
        bill_to.country_calling_code = "1"
        bill_to.phone_number = "5551234567"
        bill_to.number_is_voice_only = false
        bill_to.country = "US"
        request_obj.bill_to = bill_to

        consumer_identity = CyberSource::Acpv1tokensConsumerIdentity.new
        consumer_identity.identity_type = "EMAIL_ADDRESS"
        consumer_identity.identity_value = "john.doe@example.com"
        consumer_identity.identity_provider = "PARTNER"
        consumer_identity.identity_provider_url = "https://identity.partner.com"
        request_obj.consumer_identity = consumer_identity

        payment_information = CyberSource::Acpv1tokensPaymentInformation.new
        customer = CyberSource::Acpv1tokensPaymentInformationCustomer.new
        customer.id = ""
        payment_information.customer = customer
        payment_instrument = CyberSource::Acpv1tokensPaymentInformationPaymentInstrument.new
        payment_instrument.id = ""
        payment_information.payment_instrument = payment_instrument
        instrument_identifier = CyberSource::Acpv1tokensPaymentInformationInstrumentIdentifier.new
        instrument_identifier.id = "4044EB915C613A82E063AF598E0AE6EF"
        payment_information.instrument_identifier = instrument_identifier
        request_obj.payment_information = payment_information

        enrollment_reference_data = CyberSource::Acpv1tokensEnrollmentReferenceData.new
        enrollment_reference_data.enrollment_reference_type = "TOKEN_REFERENCE_ID"
        enrollment_reference_data.enrollment_reference_provider = "VTS"
        request_obj.enrollment_reference_data = enrollment_reference_data


        assurance_data = []
        assurance_data1 = CyberSource::Acpv1tokensAssuranceData.new
        assurance_data1.verification_type = "DEVICE"
        assurance_data1.verification_entity = "10"

        verification_events =  []
        verification_events << "01"
        assurance_data1.verification_events = verification_events
        assurance_data1.verification_method = "02"
        assurance_data1.verification_results = "01"
        assurance_data1.verification_timestamp = "1735690745"
        authentication_context1 = CyberSource::Acpv1tokensAuthenticationContext.new
        authentication_context1.action = "AUTHENTICATE"
        assurance_data1.authentication_context = authentication_context1
        authenticated_identities1 = CyberSource::Acpv1tokensAuthenticatedIdentities.new
        authenticated_identities1.data = "authenticatedData"
        authenticated_identities1.provider = "VISA_PAYMENT_PASSKEY"
        authenticated_identities1.id = "f48ac10b-58cc-4372-a567-0e02b2c3d489"
        assurance_data1.authenticated_identities = authenticated_identities1
        assurance_data1.additional_data = ""
        assurance_data << assurance_data1

        request_obj.assurance_data = assurance_data

        consent_data = []
        consent_data1 = CyberSource::Acpv1tokensConsentData.new
        consent_data1.id = "550e8400-e29b-41d4-a716-446655440000"
        consent_data1.type = "PERSONALIZATION"
        consent_data1.source = "CLIENT"
        consent_data1.accepted_time = "1719169800"
        consent_data1.effective_until = "1750705800"
        consent_data << consent_data1

        request_obj.consent_data = consent_data
        config = MerchantConfiguration.getMerchantDetailsWithRequestAndResponseMLE2()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::EnrollmentApi.new(api_client, config)

        data, status_code, headers = api_instance.enroll_card(request_obj)

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
        Acp_api_example.new.run()
    end
end