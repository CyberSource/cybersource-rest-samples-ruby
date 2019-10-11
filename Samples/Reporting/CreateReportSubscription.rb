require 'cybersource_rest_client'
require_relative '../../data/Configuration.rb'

public
class CreateReportSubscription
    def run()
        request_obj = CyberSource::CreateReportSubscriptionRequest.new
        request_obj.report_definition_name = "TransactionRequestClass"

        report_fields =  []
        report_fields << "Request.RequestID";
        report_fields << "Request.TransactionDate";
        report_fields << "Request.MerchantID";
        report_fields << "AFSFields.IPAddress";
        report_fields << "AFSFields.IPCountry";
        report_fields << "AFSFields.IPRoutingMethod";
        report_fields << "AFSFields.IPState";
        report_fields << "Application.Name";
        report_fields << "BankInfo.Address";
        report_fields << "BankInfo.BranchCode";
        report_fields << "BankInfo.City";
        report_fields << "BankInfo.Country";
        report_fields << "BankInfo.Name";
        report_fields << "BankInfo.SwiftCode";
        report_fields << "BillTo.Address1";
        report_fields << "BillTo.Address2";
        report_fields << "BillTo.City";
        report_fields << "BillTo.CompanyName";
        report_fields << "BillTo.CompanyTaxID";
        report_fields << "BillTo.Country";
        report_fields << "BillTo.Email";
        report_fields << "BillTo.FirstName";
        report_fields << "BillTo.LastName";
        report_fields << "BillTo.MiddleName";
        report_fields << "BillTo.NameSuffix";
        report_fields << "BillTo.PersonalID";
        report_fields << "BillTo.Phone";
        report_fields << "BillTo.State";
        report_fields << "BillTo.Title";
        report_fields << "BillTo.Zip";
        report_fields << "ChargebackAndRetrieval.AdjustmentAmount";
        report_fields << "ChargebackAndRetrieval.AdjustmentCurrency";
        report_fields << "ChargebackAndRetrieval.ARN";
        report_fields << "ChargebackAndRetrieval.CaseIdentifier";
        report_fields << "ChargebackAndRetrieval.CaseNumber";
        report_fields << "ChargebackAndRetrieval.CaseTime";
        report_fields << "ChargebackAndRetrieval.CaseType";
        report_fields << "ChargebackAndRetrieval.ChargebackAmount";
        report_fields << "ChargebackAndRetrieval.ChargebackCurrency";
        report_fields << "ChargebackAndRetrieval.ChargebackMessage";
        report_fields << "ChargebackAndRetrieval.ChargebackReasonCode";
        report_fields << "ChargebackAndRetrieval.ChargebackReasonCodeDescription";
        report_fields << "ChargebackAndRetrieval.ChargebackTime";
        report_fields << "ChargebackAndRetrieval.DocumentIndicator";
        report_fields << "ChargebackAndRetrieval.FeeAmount";
        report_fields << "ChargebackAndRetrieval.FeeCurrency";
        report_fields << "ChargebackAndRetrieval.FinancialImpact";
        report_fields << "ChargebackAndRetrieval.FinancialImpactType";
        report_fields << "ChargebackAndRetrieval.MerchantCategoryCode";
        report_fields << "ChargebackAndRetrieval.PartialIndicator";
        report_fields << "ChargebackAndRetrieval.ResolutionTime";
        report_fields << "ChargebackAndRetrieval.ResolvedToIndicator";
        report_fields << "ChargebackAndRetrieval.RespondByDate";
        report_fields << "ChargebackAndRetrieval.TransactionType";
        report_fields << "Check.AccountEncoderID";
        report_fields << "Check.BankTransitNumber";
        report_fields << "Check.SecCode";
        report_fields << "CustomerFields.BillingAddress1";
        report_fields << "CustomerFields.BillingAddress2";
        report_fields << "CustomerFields.BillingCity";
        report_fields << "CustomerFields.BillingCompanyName";
        report_fields << "CustomerFields.BillingCountry";
        report_fields << "CustomerFields.BillingEmail";
        report_fields << "CustomerFields.BillingFirstName";
        report_fields << "CustomerFields.BillingLastName";
        report_fields << "CustomerFields.BillingPhone";
        report_fields << "CustomerFields.BillingPostalCode";
        report_fields << "CustomerFields.BillingState";
        report_fields << "CustomerFields.CustomerID";
        report_fields << "CustomerFields.CustomerUserName";
        report_fields << "CustomerFields.PersonalId(CPF/CNPJ)";
        report_fields << "CustomerFields.ShippingAddress1";
        report_fields << "CustomerFields.ShippingAddress2";
        report_fields << "CustomerFields.ShippingCity";
        report_fields << "CustomerFields.ShippingCompanyName";
        report_fields << "CustomerFields.ShippingCountry";
        report_fields << "CustomerFields.ShippingFirstName";
        report_fields << "CustomerFields.ShippingLastName";
        report_fields << "CustomerFields.ShippingPhone";
        report_fields << "CustomerFields.ShippingPostalCode";
        report_fields << "CustomerFields.ShippingState";
        report_fields << "DecisionManagerEvents.EventPolicy";
        report_fields << "DecisionManagerEvents.TypeofEvent";
        report_fields << "Device.DeviceID";
        report_fields << "DeviceFingerprintFields.abcd";
        report_fields << "DeviceFingerprintFields.BrowserLanguage";
        report_fields << "DeviceFingerprintFields.DeviceLatitude";
        report_fields << "DeviceFingerprintFields.DeviceLongitude";
        report_fields << "DeviceFingerprintFields.displayNameFinalCheck";
        report_fields << "DeviceFingerprintFields.DMESignOffFieldEdit";
        report_fields << "DeviceFingerprintFields.Fingerprint/DeviceFingerprint";
        report_fields << "DeviceFingerprintFields.FlashEnabled";
        report_fields << "DeviceFingerprintFields.FlashOperatingSystem";
        report_fields << "DeviceFingerprintFields.FlashVersion";
        report_fields << "DeviceFingerprintFields.GPSAccuracy";
        report_fields << "DeviceFingerprintFields.ImagesEnabled";
        report_fields << "DeviceFingerprintFields.Jailbreak/RootPrivileges";
        report_fields << "DeviceFingerprintFields.JavaScriptEnabled";
        report_fields << "DeviceFingerprintFields.ProfiledURL";
        report_fields << "DeviceFingerprintFields.ProxyIPAddress";
        report_fields << "DeviceFingerprintFields.ProxyIPAddressActivities";
        report_fields << "DeviceFingerprintFields.ProxyServerType";
        report_fields << "DeviceFingerprintFields.ScreenResolution";
        report_fields << "DeviceFingerprintFields.SignOffFieldDMEEditNewOne";
        report_fields << "DeviceFingerprintFields.SmartID";
        report_fields << "DeviceFingerprintFields.SmartIDConfidenceLevel";
        report_fields << "DeviceFingerprintFields.TimeOnPage";
        report_fields << "DeviceFingerprintFields.TrueIPAddress";
        report_fields << "DeviceFingerprintFields.TrueIPAddressActivities";
        report_fields << "DeviceFingerprintFields.TrueIPAddressAttributes";
        report_fields << "DeviceFingerprintFields.txdea1";
        report_fields << "DeviceFingerprintFields.txdesv";
        report_fields << "EmailageFields.FraudType";
        report_fields << "EmailageFields.IP Postal";
        report_fields << "EmailageFields.IPCity";
        report_fields << "EmailageFields.IPCountry";
        report_fields << "EmailageFields.IPRegion";
        report_fields << "EmailageFields.SourceIndustry";
        report_fields << "Event.Amount";
        report_fields << "Event.CurrencyCode";
        report_fields << "Event.Event";
        report_fields << "Event.EventDate";
        report_fields << "Event.ProcessorMessage";
        report_fields << "Exception.Action";
        report_fields << "Exception.CYBSExceptionID";
        report_fields << "Exception.DccLookupStatus";
        report_fields << "Exception.ExceptionAmount";
        report_fields << "Exception.ExceptionAmountCurrency";
        report_fields << "Exception.ExceptionCategory";
        report_fields << "Exception.ExceptionDate";
        report_fields << "Exception.ExceptionDescription";
        report_fields << "Exception.ExceptionDeviceHardwareRevision";
        report_fields << "Exception.ExceptionDeviceID";
        report_fields << "Exception.ExceptionDeviceOS";
        report_fields << "Exception.ExceptionDeviceOSVersion";
        report_fields << "Exception.ExceptionDeviceTerminalID";
        report_fields << "Exception.ExceptionMessage";
        report_fields << "Exception.ExceptionReasonDescription";
        report_fields << "Exception.ExceptionStatus";
        report_fields << "Exception.ExceptionStatusCode";
        report_fields << "Exception.ExceptionType";
        report_fields << "Exception.FinancialStatus";
        report_fields << "Exception.LastActionDate";
        report_fields << "Exception.NextActionDate";
        report_fields << "Exception.OriginalTransactionSubmissionDate";
        report_fields << "Exception.PaymentNumber";
        report_fields << "Exception.ProcessorCaseID";
        report_fields << "Exception.ProcessorResponseCode";
        report_fields << "Exception.ReasonCode";
        report_fields << "Exception.RetryCount";
        report_fields << "Fee.AssessmentAmount";
        report_fields << "Fee.AssessmentCurrency";
        report_fields << "Fee.BillingCycle";
        report_fields << "Fee.BillingType";
        report_fields << "Fee.ClearedInterchangeLevel";
        report_fields << "Fee.DiscountAmount";
        report_fields << "Fee.DiscountCurrency";
        report_fields << "Fee.DiscountRate";
        report_fields << "Fee.DowngradeReasonCode";
        report_fields << "Fee.InterchangeAmount";
        report_fields << "Fee.InterchangeCurrency";
        report_fields << "Fee.InterchangeRate";
        report_fields << "Fee.PerItemFeeAmount";
        report_fields << "Fee.PerItemFeeCurrency";
        report_fields << "Fee.PricedInterchangeLevel";
        report_fields << "Fee.ServiceFeeAmount";
        report_fields << "Fee.ServiceFeeAmountCcy";
        report_fields << "Fee.ServiceFeeFixedAmount";
        report_fields << "Fee.ServiceFeeFixedAmountCcy";
        report_fields << "Fee.ServiceFeeRate";
        report_fields << "Fee.SettlementAmount";
        report_fields << "Fee.SettlementCurrency";
        report_fields << "Fee.SettlementTime";
        report_fields << "Fee.SettlementTimeZone";
        report_fields << "Fee.SourceDescriptor";
        report_fields << "Fee.TotalFeeAmount";
        report_fields << "Fee.TotalFeeCurrency";
        report_fields << "Funding.AdjustmentAmount";
        report_fields << "Funding.AdjustmentCurrency";
        report_fields << "Funding.AdjustmentDescription";
        report_fields << "Funding.AdjustmentType";
        report_fields << "FundTransfer.BankCheckDigit";
        report_fields << "FundTransfer.IbanIndicator";
        report_fields << "Invoice.BillingGroupDescription";
        report_fields << "Invoice.NotProcessed";
        report_fields << "Invoice.OrganizationID";
        report_fields << "Invoice.PerformedServices";
        report_fields << "Invoice.Processed";
        report_fields << "Invoice.Total";
        report_fields << "JP.Amount";
        report_fields << "JP.AuthForward";
        report_fields << "JP.AuthorizationCode";
        report_fields << "JP.CardSuffix";
        report_fields << "JP.Currency";
        report_fields << "JP.CustomerFirstName";
        report_fields << "JP.CustomerLastName";
        report_fields << "JP.Date";
        report_fields << "JP.Gateway";
        report_fields << "JP.JPOInstallmentMethod";
        report_fields << "JP.JPOPaymentMethod";
        report_fields << "JP.MerchantID";
        report_fields << "JP.MerchantReferenceNumber";
        report_fields << "JP.PaymentMethod";
        report_fields << "JP.RequestID";
        report_fields << "JP.SubscriptionID";
        report_fields << "JP.Time";
        report_fields << "JP.TransactionReferenceNumber";
        report_fields << "JP.TransactionType";
        report_fields << "LineItems.FulfillmentType";
        report_fields << "LineItems.InvoiceNumber";
        report_fields << "LineItems.MerchantProductSku";
        report_fields << "LineItems.ProductCode";
        report_fields << "LineItems.ProductName";
        report_fields << "LineItems.Quantity";
        report_fields << "LineItems.TaxAmount";
        report_fields << "LineItems.UnitPrice";
        report_fields << "MarkAsSuspectFields.MarkingDate";
        report_fields << "MarkAsSuspectFields.MarkingNotes";
        report_fields << "MarkAsSuspectFields.MarkingReason";
        report_fields << "MarkAsSuspectFields.MarkingUserName";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData1";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData10";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData100";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData11";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData12";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData13";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData14";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData15";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData16";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData17";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData18";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData19";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData2";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData20";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData21";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData22";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData23";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData24";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData25";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData26";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData27";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData28";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData29";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData3";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData30";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData31";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData32";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData34";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData35";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData36";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData37";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData39";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData4";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData40";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData41";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData43";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData44";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData45";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData46";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData48";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData49";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData5";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData50";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData52";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData53";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData54";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData56";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData57";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData58";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData59";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData6";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData61";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData62";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData63";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData65";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData66";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData67";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData68";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData7";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData70";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData71";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData72";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData73";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData74";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData75";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData76";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData77";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData78";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData79";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData8";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData80";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData81";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData82";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData83";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData84";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData85";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData86";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData87";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData88";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData89";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData9";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData90";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData91";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData92";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData93";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData94";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData95";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData96";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData97";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData98";
        report_fields << "Merchant-DefinedDataFields.MerchantDefinedData99";
        report_fields << "OctSummary.AccountId";
        report_fields << "OctSummary.ResellerId";
        report_fields << "OctSummary.SettlementAmountCurrency";
        report_fields << "OctSummary.SettlementDate";
        report_fields << "OctSummary.TransactionAmountCurrency";
        report_fields << "OrderFields.ConnectionMethod";
        report_fields << "OrderFields.MerchantID";
        report_fields << "OrderFields.MerchantReferenceNumber";
        report_fields << "OrderFields.ReasonCode";
        report_fields << "OrderFields.ReplyCode";
        report_fields << "OrderFields.ReplyFlag";
        report_fields << "OrderFields.ReplyMessage";
        report_fields << "OrderFields.RequestID";
        report_fields << "OrderFields.ShippingMethod";
        report_fields << "OrderFields.TransactionDate";
        report_fields << "PayerAuth.RequestID";
        report_fields << "PayerAuth.TransactionType";
        report_fields << "PaymentData.ACHVerificationResult";
        report_fields << "PaymentData.ACHVerificationResultMapped";
        report_fields << "PaymentData.AcquirerMerchantID";
        report_fields << "PaymentData.AuthIndicator";
        report_fields << "PaymentData.AuthorizationCode";
        report_fields << "PaymentData.AuthorizationType";
        report_fields << "PaymentData.AuthReversalAmount";
        report_fields << "PaymentData.AuthReversalResult";
        report_fields << "PaymentData.AVSResult";
        report_fields << "PaymentData.AVSResultMapped";
        report_fields << "PaymentData.BalanceAmount";
        report_fields << "PaymentData.BalanceCurrencyCode";
        report_fields << "PaymentData.BinNumber";
        report_fields << "PaymentData.CardCategory";
        report_fields << "PaymentData.CardCategoryCode";
        report_fields << "PaymentData.CardPresent";
        report_fields << "PaymentData.CurrencyCode";
        report_fields << "PaymentData.CVResult";
        report_fields << "PaymentData.DCCIndicator";
        report_fields << "PaymentData.EMVRequestFallBack";
        report_fields << "PaymentData.EVEmail";
        report_fields << "PaymentData.EVEmailRaw";
        report_fields << "PaymentData.EVName";
        report_fields << "PaymentData.EVNameRaw";
        report_fields << "PaymentData.EVPhoneNumber";
        report_fields << "PaymentData.EVPhoneNumberRaw";
        report_fields << "PaymentData.EVPostalCode";
        report_fields << "PaymentData.EVPostalCodeRaw";
        report_fields << "PaymentData.EVStreet";
        report_fields << "PaymentData.EVStreetRaw";
        report_fields << "PaymentData.ExchangeRate";
        report_fields << "PaymentData.ExchangeRateDate";
        report_fields << "PaymentData.MandateReferenceNumber";
        report_fields << "PaymentData.NetworkCode";
        report_fields << "PaymentData.NetworkTransactionID";
        report_fields << "PaymentData.NumberOfInstallments";
        report_fields << "PaymentData.OriginalAmount";
        report_fields << "PaymentData.OriginalCurrency";
        report_fields << "PaymentData.PaymentProductCode";
        report_fields << "PaymentData.POSEntryMode";
        report_fields << "PaymentData.ProcessorMID";
        report_fields << "PaymentData.ProcessorResponseCode";
        report_fields << "PaymentData.ProcessorResponseID";
        report_fields << "PaymentData.ProcessorTID";
        report_fields << "PaymentData.ProcessorTransactionID";
        report_fields << "PaymentData.RequestedAmount";
        report_fields << "PaymentData.RequestedAmountCurrencyCode";
        report_fields << "PaymentData.SubMerchantCity";
        report_fields << "PaymentData.SubMerchantCountry";
        report_fields << "PaymentData.SubMerchantEmail";
        report_fields << "PaymentData.SubMerchantID";
        report_fields << "PaymentData.SubMerchantName";
        report_fields << "PaymentData.SubMerchantPhone";
        report_fields << "PaymentData.SubMerchantPostalCode";
        report_fields << "PaymentData.SubMerchantState";
        report_fields << "PaymentData.SubMerchantStreet";
        report_fields << "PaymentData.TargetAmount";
        report_fields << "PaymentData.TargetCurrency";
        report_fields << "PaymentFields.AccountSuffix";
        report_fields << "PaymentFields.CardBIN";
        report_fields << "PaymentFields.CardBINCountry";
        report_fields << "PaymentFields.CardIssuer";
        report_fields << "PaymentFields.CardScheme";
        report_fields << "PaymentFields.CardType";
        report_fields << "PaymentFields.CardVerificationResult";
        report_fields << "PaymentMethod.AccountSuffix";
        report_fields << "PaymentMethod.AdditionalCardType";
        report_fields << "PaymentMethod.BankAccountName";
        report_fields << "PaymentMethod.BankCode";
        report_fields << "PaymentMethod.BoletoBarCodeNumber";
        report_fields << "PaymentMethod.BoletoNumber";
        report_fields << "PaymentMethod.CardType";
        report_fields << "PaymentMethod.CheckNumber";
        report_fields << "PaymentMethod.ExpirationMonth";
        report_fields << "PaymentMethod.ExpirationYear";
        report_fields << "PaymentMethod.IssueNumber";
        report_fields << "PaymentMethod.MandateId";
        report_fields << "PaymentMethod.StartMonth";
        report_fields << "PaymentMethod.StartYear";
        report_fields << "PaymentMethod.WalletType";
        report_fields << "POSTerminalExceptions.AccountSuffix";
        report_fields << "POSTerminalExceptions.CurrencyCode";
        report_fields << "POSTerminalExceptions.ExpirationMO";
        report_fields << "POSTerminalExceptions.ExpirationYR";
        report_fields << "POSTerminalExceptions.LastName";
        report_fields << "POSTerminalExceptions.MerchantID";
        report_fields << "Recipient.RecipientBillingAmount";
        report_fields << "Recipient.RecipientBillingCurrency";
        report_fields << "Recipient.ReferenceNumber";
        report_fields << "Request.PartnerOriginalTransactionID";
        report_fields << "Sender.Address";
        report_fields << "Sender.City";
        report_fields << "Sender.Country";
        report_fields << "Sender.DOB";
        report_fields << "Sender.FirstName";
        report_fields << "Sender.LastName";
        report_fields << "Sender.MiddleInitial";
        report_fields << "Sender.PhoneNumber";
        report_fields << "Sender.PostalCode";
        report_fields << "Sender.SenderReferenceNumber";
        report_fields << "Sender.SourceOfFunds";
        report_fields << "Sender.State";
        report_fields << "ShipTo.CompanyName";
        report_fields << "Subscriptions.Applications";
        report_fields << "Subscriptions.AuthAVSResults";
        report_fields << "Subscriptions.AuthCardVerificationResult";
        report_fields << "Subscriptions.AuthCode";
        report_fields << "Subscriptions.AuthRCode";
        report_fields << "Subscriptions.AuthResponseCode";
        report_fields << "Subscriptions.AuthType";
        report_fields << "Subscriptions.BillToAddress1";
        report_fields << "Subscriptions.BillToAddress2";
        report_fields << "Subscriptions.BillToCity";
        report_fields << "Subscriptions.BillToCompanyName";
        report_fields << "Subscriptions.BillToCountry";
        report_fields << "Subscriptions.BillToEmail";
        report_fields << "Subscriptions.BillToFirstName";
        report_fields << "Subscriptions.BillToLastName";
        report_fields << "Subscriptions.BillToState";
        report_fields << "Subscriptions.BillToZip";
        report_fields << "Subscriptions.CardType";
        report_fields << "Subscriptions.Comments";
        report_fields << "Subscriptions.ConsumerPhone";
        report_fields << "Subscriptions.CurrencyCode";
        report_fields << "Subscriptions.CustomerCCAccountSuffix";
        report_fields << "Subscriptions.CustomerCCExpiryMonth";
        report_fields << "Subscriptions.CustomerCCExpiryYear";
        report_fields << "Subscriptions.CustomerCCIssueNo";
        report_fields << "Subscriptions.CustomerCCRoutingNumber";
        report_fields << "Subscriptions.CustomerCCStartMonth";
        report_fields << "Subscriptions.CustomerCCStartYear";
        report_fields << "Subscriptions.CustomerCCSubTypeDescription";
        report_fields << "Subscriptions.EcommerceIndicator";
        report_fields << "Subscriptions.IPAddress";
        report_fields << "Subscriptions.MerchantDefinedData1";
        report_fields << "Subscriptions.MerchantDefinedData2";
        report_fields << "Subscriptions.MerchantDefinedData3";
        report_fields << "Subscriptions.MerchantDefinedData4";
        report_fields << "Subscriptions.MerchantRefNo";
        report_fields << "Subscriptions.MerchantSecureData1";
        report_fields << "Subscriptions.MerchantSecureData2";
        report_fields << "Subscriptions.MerchantSecureData3";
        report_fields << "Subscriptions.MerchantSecureData4";
        report_fields << "Subscriptions.PaymentProcessor";
        report_fields << "Subscriptions.PaymentsSuccess";
        report_fields << "Subscriptions.RCode";
        report_fields << "Subscriptions.ReasonCode";
        report_fields << "Subscriptions.RequestID";
        report_fields << "Subscriptions.RequestToken";
        report_fields << "Subscriptions.RFlag";
        report_fields << "Subscriptions.RMsg";
        report_fields << "Subscriptions.ShipToAddress1";
        report_fields << "Subscriptions.ShipToAddress2";
        report_fields << "Subscriptions.ShipToCity";
        report_fields << "Subscriptions.ShipToCompanyName";
        report_fields << "Subscriptions.ShipToCountry";
        report_fields << "Subscriptions.ShipToFirstName";
        report_fields << "Subscriptions.ShipToLastName";
        report_fields << "Subscriptions.ShipToState";
        report_fields << "Subscriptions.ShipToZip";
        report_fields << "Subscriptions.SubscriptionID";
        report_fields << "Subscriptions.TaxAmount";
        report_fields << "Subscriptions.TransactionDate";
        report_fields << "Subscriptions.TransRefNo";
        report_fields << "TaxCalculation.Status";
        report_fields << "Token.NetworkTokenTransType";
        report_fields << "Token.TokenCode";
        report_fields << "TransactionDetails.MerchantId";
        report_fields << "TransactionDetails.PaymentMethodDesc";
        report_fields << "TransactionDetails.PaymentMethodType";
        report_fields << "TransactionDetails.RequestId";
        report_fields << "TravelFields.DepartureTime";
        report_fields << "VelocityMorphing.FieldName";
        report_fields << "VelocityMorphing.InfoCode";
        report_fields << "WhitepagesProFields.EmailDomainCreationDate";
        request_obj.report_fields = report_fields
        request_obj.report_mime_type = "application/xml"
        request_obj.report_frequency = "WEEKLY"
        request_obj.report_name = "testrest_subcription_v1"
        request_obj.timezone = "GMT"
        request_obj.start_time = "0900"
        request_obj.start_day = 1

        opts = {}

        config = MerchantConfiguration.new.merchantConfigProp()
        api_client = CyberSource::ApiClient.new
        api_instance = CyberSource::ReportSubscriptionsApi.new(api_client, config)

        data, status_code, headers = api_instance.create_subscription(request_obj, opts)

        return data, status_code, headers
    rescue StandardError => err
        puts err.message
    end
    if __FILE__ == $0

        CreateReportSubscription.new.run()
    end
end
