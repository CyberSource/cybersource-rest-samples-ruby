require 'cybersource_rest_client'
require_relative '../service/PaymentRequestService.rb'

public
# ApiContoller has a payment method.
# The controller class decides the next step in moving the logic from
#  Sample code to servicing the payment request.
class APIController
  def payment_get(merchantconfig_obj)
    response_code, response_body, vc_correlationid = PaymentService.new.paymentService(merchantconfig_obj)
    return response_code, response_body, vc_correlationid
  end

  def payment_post(merchantconfig_obj)
    response_code, response_body, vc_correlationid = PaymentService.new.paymentService(merchantconfig_obj)
    return response_code, response_body, vc_correlationid
  end
  
  def payment_put(merchantconfig_obj)
    response_code, response_body, vc_correlationid = PaymentService.new.paymentService(merchantconfig_obj)
    return response_code, response_body, vc_correlationid
  end
  def payment_delete(merchantconfig_obj)
    response_code, response_body, vc_correlationid = PaymentService.new.paymentService(merchantconfig_obj)
    return response_code, response_body, vc_correlationid
  end
end
