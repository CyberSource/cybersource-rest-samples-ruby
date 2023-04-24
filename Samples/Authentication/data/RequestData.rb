require_relative '../../../lib/SampleApiClient/model/AggregatorInformation.rb'
require_relative '../../../lib/SampleApiClient/model/AmountDetails.rb'
require_relative '../../../lib/SampleApiClient/model/BillTo.rb'
require_relative '../../../lib/SampleApiClient/model/Card.rb'
require_relative '../../../lib/SampleApiClient/model/ClientReferenceInformation.rb'
require_relative '../../../lib/SampleApiClient/model/OrderInformation.rb'
require_relative '../../../lib/SampleApiClient/model/PaymentInformation.rb'
require_relative '../../../lib/SampleApiClient/model/Payments.rb'
require_relative '../../../lib/SampleApiClient/model/ProcessingInformation.rb'
require_relative '../../../lib/SampleApiClient/model/SubMerchant.rb'
require 'json'
require 'yaml'
public
class RequestData 
  public
  def jsonFileData(jsonPath)
    requestJsonData = ""
    if (!File.exist?(jsonPath)) then
       raise CyberSourceAuthentication::Constants::ERROR_PREFIX + CyberSourceAuthentication::Constants::REQUEST_JSON_ERROR + File.expand_path(jsonPath)
    end
    if(File.exist?(jsonPath)) then
      requestJsonData = File.read(jsonPath)
    end
    return requestJsonData
  end
  public 
  def samplePaymentsData()
    clientReferenceInformation = ClientReferenceInformation.new code = "TC50171_3"
    clientReferenceInformationHash = {}
    clientReferenceInformation.instance_variables.each {|var| clientReferenceInformationHash[var.to_s.delete("@")] = clientReferenceInformation.instance_variable_get(var)}

    processingInformation = ProcessingInformation.new commerceIndicator = "internet"
    processingInformationHash = {}
    processingInformation.instance_variables.each {|var| processingInformationHash[var.to_s.delete("@")] = processingInformation.instance_variable_get(var)}

    subMerchant = SubMerchant.new(
    cardAcceptorID = "1234567890",
    country = "US",
    phoneNumber = "650-432-0000",
    address1 = "900 Metro Center",
    postalCode = "94404-2775",
    locality = "Foster Cit",
    name = "Visa Inc",
    administrativeArea = "CA",
    region = "PEN",
    email = "test@cybs.com")
    subMerchantHash = {}
    subMerchant.instance_variables.each {|var| subMerchantHash[var.to_s.delete("@")] = subMerchant.instance_variable_get(var)}

    aggregatorInformation = AggregatorInformation.new(
    subMerchant = subMerchantHash,
    name = "V-Internatio",
    aggregatorID = "123456789")
    aggregatorInformationHash = {}
    aggregatorInformation.instance_variables.each {|var| aggregatorInformationHash[var.to_s.delete("@")] = aggregatorInformation.instance_variable_get(var)}

    billTo = BillTo.new(
      country = "US",
      lastName = "VDP",
      address2 = "Address 2",
      address1 = "201 S. Division St.",
      postalCode = "48104-2201",
      locality = "Ann Arbor",
      administrativeArea = "MI",
      firstName = "RTS",
      phoneNumber = "999999999",
      district = "MI",
      buildingNumber = "123",
      company = "Visa",
      email = "test@cybs.com")
    billToHash = {}
    billTo.instance_variables.each {|var| billToHash[var.to_s.delete("@")] = billTo.instance_variable_get(var)}

    amountDetails = AmountDetails.new(
      totalAmount = "102.21",
      currency = "USD")
    amountDetailsHash = {}
    amountDetails.instance_variables.each {|var| amountDetailsHash[var.to_s.delete("@")] = amountDetails.instance_variable_get(var)}

    orderInformation = OrderInformation.new(
      billTo = billToHash,
      amountDetails = amountDetailsHash)
    orderInformationHash = {}
    orderInformation.instance_variables.each {|var| orderInformationHash[var.to_s.delete("@")] = orderInformation.instance_variable_get(var)}

    card = Card.new(
      expirationYear = "2031",
      number = "5555555555554444",
      securityCode = "123",
      expirationMonth = "12",
      type = "002")
      cardHash = {}
      card.instance_variables.each {|var| cardHash[var.to_s.delete("@")] = card.instance_variable_get(var)}

    paymentInformation = PaymentInformation.new (card = cardHash)
    paymentInformationHash = {}
    paymentInformation.instance_variables.each {|var| paymentInformationHash[var.to_s.delete("@")] = paymentInformation.instance_variable_get(var)}

    payments = Payments.new(
      clientReferenceInformation = clientReferenceInformationHash,
      processingInformation = processingInformationHash,
      aggregatorInformation = aggregatorInformationHash,
      orderInformation = orderInformationHash,
      paymentInformation = paymentInformationHash)
    paymentsHash = {}
    payments.instance_variables.each {|var| paymentsHash[var.to_s.delete("@")] = payments.instance_variable_get(var)}
    return JSON.generate(paymentsHash)
  end
end
