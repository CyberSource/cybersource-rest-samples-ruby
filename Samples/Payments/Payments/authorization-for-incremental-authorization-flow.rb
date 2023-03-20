require 'cybersource_rest_client'
require_relative '../../../data/Configuration.rb'

public
class Authorization_for_incremental_authorization_flow
    def run()
        request_obj = CyberSource::CreatePaymentRequest.new
        processing_information = CyberSource::Ptsv2paymentsProcessingInformation.new
        processing_information.capture = false
        processing_information.industry_data_type = "lodging"
        request_obj.processing_information = processing_information

        payment_information = CyberSource::Ptsv2paymentsPaymentInformation.new
        card = CyberSource::Ptsv2paymentsPaymentInformationCard.new
        card.number = "4111111111111111"
        card.expiration_month = "12"
        card.expiration_year = "2021"
        card.type = "001"
        payment_information.card = card
        tokenized_card = CyberSource::Ptsv2paymentsPaymentInformationTokenizedCard.new
        tokenized_card.security_code = "123"
        payment_information.tokenized_card = tokenized_card
        request_obj.payment_information = payment_information

        order_information = CyberSource::Ptsv2paymentsOrderInformation.new
        amount_details = CyberSource::Ptsv2paymentsOrderInformationAmountDetails.new
        amount_details.total_amount = "20"
        amount_details.currency = "USD"
        order_information.amount_details = amount_details
        bill_to = CyberSource::Ptsv2paymentsOrderInformationBillTo.new
        bill_to.first_name = "John"
        bill_to.last_name = "Smith"
        bill_to.address1 = "201 S. Division St."
        bill_to.address2 = "Suite 500"
        bill_to.locality = "Ann Arbor"
        bill_to.administrative_area = "MI"
        bill_to.postal_code = "12345"
        bill_to.country = "US"
        bill_to.email = "null@cybersource.com"
        bill_to.phone_number = "514-670-8700"
        order_information.bill_to = bill_to
        ship_to = CyberSource::Ptsv2paymentsOrderInformationShipTo.new
        ship_to.first_name = "Olivia"
        ship_to.last_name = "White"
        ship_to.address1 = "1295 Charleston Rd"
        ship_to.address2 = "Cube 2386"
        ship_to.locality = "Mountain View"
        ship_to.administrative_area = "CA"
        ship_to.postal_code = "94041"
        ship_to.country = "AE"
        ship_to.phone_number = "650-965-6000"
        order_information.ship_to = ship_to
        request_obj.order_information = order_information

        merchant_information = CyberSource::Ptsv2paymentsMerchantInformation.new
        merchant_descriptor = CyberSource::Ptsv2paymentsMerchantInformationMerchantDescriptor.new
        merchant_descriptor.contact = "965-6000"
        merchant_information.merchant_descriptor = merchant_descriptor
        request_obj.merchant_information = merchant_information

        consumer_authentication_information = CyberSource::Ptsv2paymentsConsumerAuthenticationInformation.new
        consumer_authentication_information.cavv = "ABCDEabcde12345678900987654321abcdeABCDE"
        consumer_authentication_information.xid = "12345678909876543210ABCDEabcdeABCDEF1234"
        request_obj.consumer_authentication_information = consumer_authentication_information

        installment_information = CyberSource::Ptsv2paymentsInstallmentInformation.new
        installment_information.amount = "1200"
        installment_information.frequency = "W"
        installment_information.sequence = 34
        installment_information.total_amount = "2000"
        installment_information.total_count = 12
        request_obj.installment_information = installment_information

        travel_information = CyberSource::Ptsv2paymentsTravelInformation.new
        travel_information.duration = "3"
        lodging = CyberSource::Ptsv2paymentsTravelInformationLodging.new
        lodging.check_in_date = "110620"
        lodging.check_out_date = "110920"

        room = []
        room1 = CyberSource::Ptsv2paymentsTravelInformationLodgingRoom.new
        room1.daily_rate = "1.50"
        room1.number_of_nights = 5
        room << room1

        room2 = CyberSource::Ptsv2paymentsTravelInformationLodgingRoom.new
        room2.daily_rate = "11.50"
        room2.number_of_nights = 5
        room << room2

        lodging.room = room
        lodging.smoking_preference = "Y"
        lodging.number_of_rooms = 1
        lodging.number_of_guests = 3
        lodging.room_bed_type = "king"
        lodging.room_tax_type = "tourist"
        lodging.room_rate_type = "sr citizen"
        lodging.guest_name = "Tulasi"
        lodging.customer_service_phone_number = "+13304026334"
        lodging.corporate_client_code = "HDGGASJDGSUY"
        lodging.additional_discount_amount = "99.123456781"
        lodging.room_location = "seaview"
        lodging.special_program_code = "2"
        lodging.total_tax_amount = "99.123"
        lodging.prepaid_cost = "9999.99"
        lodging.food_and_beverage_cost = "9999.99"
        lodging.room_tax_amount = "9999.99"
        lodging.adjustment_amount = "9999.99"
        lodging.phone_cost = "9999.99"
        lodging.restaurant_cost = "9999.99"
        lodging.room_service_cost = "9999.99"
        lodging.mini_bar_cost = "9999.99"
        lodging.laundry_cost = "9999.99"
        lodging.miscellaneous_cost = "9999.99"
        lodging.gift_shop_cost = "9999.99"
        lodging.movie_cost = "9999.99"
        lodging.health_club_cost = "9999.99"
        lodging.valet_parking_cost = "9999.99"
        lodging.cash_disbursement_cost = "9999.99"
        lodging.non_room_cost = "9999.99"
        lodging.business_center_cost = "9999.99"
        lodging.lounge_bar_cost = "9999.99"
        lodging.transportation_cost = "9999.99"
        lodging.gratuity_amount = "9999.99"
        lodging.conference_room_cost = "9999.99"
        lodging.audio_visual_cost = "9999.99"
        lodging.non_room_tax_amount = "9999.99"
        lodging.early_check_out_cost = "9999.99"
        lodging.internet_access_cost = "9999.99"
        travel_information.lodging = lodging
        request_obj.travel_information = travel_information

        promotion_information = CyberSource::Ptsv2paymentsPromotionInformation.new
        promotion_information.additional_code = "999999.99"
        request_obj.promotion_information = promotion_information

        config = MerchantConfiguration.new.alternativeMerchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::PaymentsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_payment(request_obj)

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

        Authorization_for_incremental_authorization_flow.new.run()
    end
end
