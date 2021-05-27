require 'cybersource_rest_client'
require 'json'

public
class StandAloneOAuth

    def merchantConfigProp()
        runEnvironment='cybersource.environment.mutualauth.sandbox'        
        authenticationType='mutual_auth'
        enableClientCert = true
        clientCertDirectory = 'resource'
        sslClientCert = 'paymentsdemo.crt'
        privateKey = 'paymentsdemo.pem'
        # sslKeyPassword = ''
        clientId = '3sEPsYUFtz'
        clientSecret = '79fcae20-433f-49f8-b8e6-a8273205a010'
        
        configurationDictionary={}
        configurationDictionary['runEnvironment']=runEnvironment
        configurationDictionary['authenticationType']=authenticationType
        configurationDictionary['enableClientCert']=enableClientCert
        configurationDictionary['clientCertDirectory']=clientCertDirectory
        configurationDictionary['sslClientCert']=sslClientCert
        configurationDictionary['privateKey']=privateKey
        # configurationDictionary['sslKeyPassword']=sslKeyPassword
        configurationDictionary['clientId'] = clientId
        configurationDictionary['clientSecret'] = clientSecret
        return configurationDictionary
      end

    def simple_authorizationinternet(refresh_token, access_token)
        request_obj = CyberSource::CreatePaymentRequest.new
        client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
        client_reference_information.code = "TC50171_3"
        request_obj.client_reference_information = client_reference_information

        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false        
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2031"
        payment_information.card = card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "102.21"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Doe"
        bill_to.address1 = "1 Market St"
        bill_to.locality = "san francisco"
        bill_to.administrative_area = "CA"
        bill_to.postal_code = "94105"
        bill_to.country = "US"
        bill_to.email = "test@cybs.com"
        bill_to.phone_number = "4158880000"
        order_information.bill_to = bill_to
        request_obj.order_information = order_information

        config = merchantConfigProp()
        config["accessToken"] = access_token
        config["refreshToken"] = refresh_token
        config['authenticationType'] = 'oauth'
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

        puts data, status_code, headers
    rescue StandardError => err
        puts err.message
    end

    def postAccessTokenFromAuthCode(code, grant_type)
        request_obj = CyberSource::CreateAccessTokenRequest.new
        config = merchantConfigProp()

        request_obj.client_id = config["clientId"]
        request_obj.grant_type = grant_type
        request_obj.code = code
        request_obj.client_secret = config["clientSecret"]
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::OAuthApi.new(api_client, config)
        data, status_code, headers = api_instance.create_access_token(request_obj)
        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end

    def postAccessTokenFromRefreshToken(refresh_token, grant_type)
        request_obj = CyberSource::CreateAccessTokenRequest.new
        config = merchantConfigProp()

        request_obj.client_id = config["clientId"]
        request_obj.grant_type = grant_type
        request_obj.refresh_token = refresh_token
        request_obj.client_secret = config["clientSecret"]
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::OAuthApi.new(api_client, config)
        data, status_code, headers = api_instance.create_access_token(request_obj)
        puts data, status_code, headers
        return data
    rescue StandardError => err
        puts err.message
    end

    def run()
        result = nil
        create_using_auth_code = true
        if create_using_auth_code
            code = ""
            grant_type = "authorization_code"
            result = postAccessTokenFromAuthCode(code, grant_type)
        else
            grant_type = "refresh_token"
            refresh_token = ""
            result = postAccessTokenFromRefreshToken(refresh_token, grant_type)
        end

        if !result.nil? 
            result = JSON.parse(result)
            refresh_token = result["refresh_token"]
            access_token = result["access_token"]

            #Call Payments SampleCode using OAuth, Set Authentication to OAuth in Sample Code Configuration
            simple_authorizationinternet(refresh_token, access_token)
        end        
    end

    if __FILE__ == $0        
        StandAloneOAuth.new.run()
    end
end
