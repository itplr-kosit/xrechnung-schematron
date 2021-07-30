<pattern xmlns="http://purl.oclc.org/dsdl/schematron" is-a="ubl-model" id="model-pattern">
  <param name="BR-DE-01" value="cac:PaymentMeans"/>
  <param name="BR-DE-02" value="cac:Party/cac:Contact"/>
  <param name="BR-DE-03" value="cbc:CityName[boolean(normalize-space(.))]"/>
  <param name="BR-DE-04" value="cbc:PostalZone[boolean(normalize-space(.))]"/>
  <param name="BR-DE-05" value="cbc:Name[boolean(normalize-space(.))]"/>
  <param name="BR-DE-06" value="cbc:Telephone[boolean(normalize-space(.))]"/>
  <param name="BR-DE-07" value="cbc:ElectronicMail[boolean(normalize-space(.))]"/>
  <param name="BR-DE-08" value="cbc:CityName[boolean(normalize-space(.))]"/>
  <param name="BR-DE-09" value="cbc:PostalZone[boolean(normalize-space(.))]"/>
  <param name="BR-DE-10" value="cbc:CityName[boolean(normalize-space(.))]"/>
  <param name="BR-DE-11" value="cbc:PostalZone[boolean(normalize-space(.))]"/>
  <param name="BR-DE-14" value="cac:TaxCategory/cbc:Percent[boolean(normalize-space(.))]"/>
  <param name="BR-DE-15" value="cbc:BuyerReference[boolean(normalize-space(.))]"/>
  <!-- In BR-DE-16 'if a then b else true' has been reshaped to 'not a or b' -->
  <param name="BR-DE-16" value="not((cac:AllowanceCharge/cac:TaxCategory/cbc:ID[ancestor::cac:AllowanceCharge/cbc:ChargeIndicator = 'false' and following-sibling::cac:TaxScheme/cbc:ID = 'VAT'] = ('S', 'Z', 'E', 'AE', 'K', 'G', 'L', 'M')) or 
                                    (cac:AllowanceCharge/cac:TaxCategory/cbc:ID[ancestor::cac:AllowanceCharge/cbc:ChargeIndicator = 'true'] = ('S', 'Z', 'E', 'AE', 'K', 'G', 'L', 'M')) or
                                    (cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:ID = ('S', 'Z', 'E', 'AE', 'K', 'G', 'L', 'M'))) or 
                                (cac:TaxRepresentativeParty, cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID[boolean(normalize-space(.))])"/>
  <param name="BR-DE-17"
    value="cbc:InvoiceTypeCode = ('326', '380', '384', '389', '381', '875', '876', '877')" />
  <param name="BR-DE-18"
    value="every $line 
             in cac:PaymentTerms/cbc:Note[1]/tokenize(. , '(\r?\n)')[starts-with( normalize-space(.) , '#')] 
           satisfies matches (
                       normalize-space ($line),
                       $XR-SKONTO-REGEX
                   ) and matches( cac:PaymentTerms/cbc:Note[1]/text(), '\n\s*$' )
          " />
   
  <param name="BR-DE-19"
    value="not(cbc:PaymentMeansCode = '58') or  matches(normalize-space(replace(cac:PayeeFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')), '^[A-Z]{2}[0-9]{2}[a-zA-Z0-9]{0,30}$') and xs:integer(string-join(for $cp in string-to-codepoints(concat(substring(normalize-space(replace(cac:PayeeFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),5),upper-case(substring(normalize-space(replace(cac:PayeeFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),1,2)),substring(normalize-space(replace(cac:PayeeFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),3,2))) return  (if($cp > 64) then $cp - 55 else  $cp - 48),'')) mod 97 = 1"/>
  <param name="BR-DE-20"
    value="not(cbc:PaymentMeansCode = '59') or  matches(normalize-space(replace(cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')), '^[A-Z]{2}[0-9]{2}[a-zA-Z0-9]{0,30}$') and xs:integer(string-join(for $cp in string-to-codepoints(concat(substring(normalize-space(replace(cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),5),upper-case(substring(normalize-space(replace(cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),1,2)),substring(normalize-space(replace(cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID, '([ \n\r\t\s])', '')),3,2))) return  (if($cp > 64) then $cp - 55 else  $cp - 48),'')) mod 97 = 1"/>
    
  <param name="BR-DE-21"
    value="cbc:CustomizationID = $XR-CIUS-ID or cbc:CustomizationID = $XR-EXTENSION-ID"/>
  <param name="BR-DE-22"
    value="count(cac:AdditionalDocumentReference) = count(cac:AdditionalDocumentReference[not(./cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@filename = preceding-sibling::cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@filename)])"/>
    
  <param name="BR-DE-23a" value="cac:PayeeFinancialAccount"/>
  <param name="BR-DE-23b" value="not(cac:CardAccount) and not(cac:PaymentMandate)"/>
  
  <param name="BR-DE-24a" value="cac:CardAccount"/>
  <param name="BR-DE-24b" value="not(cac:PayeeFinancialAccount) and not(cac:PaymentMandate)"/>
  
  <param name="BR-DE-25a" value="cac:PaymentMandate"/>
  <param name="BR-DE-25b" value="not(cac:PayeeFinancialAccount) and not(cac:CardAccount)"/>

  <param name="BR-DE-26"
    value="not(cbc:InvoiceTypeCode = 384)
    or (cac:BillingReference/cac:InvoiceDocumentReference)"/>
    
  <param name="INVOICE" value="/ubl:Invoice"/>
  <param name="BG-4_SELLER" value="/ubl:Invoice/cac:AccountingSupplierParty" />
  <param name="BG-5_SELLER_POSTAL_ADDRESS"
    value="/ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress" />
  <param name="BG-6_SELLER_CONTACT"
    value="/ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact" />

  <param name="BG-8_BUYER_POSTAL_ADDRESS"
    value="/ubl:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress" />

  <param name="BG-15_DELIVER_TO_ADDRESS"
    value="/ubl:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address" />

  <param name="BG-17_CREDIT_TRANSFER" value="/ubl:Invoice/cac:PaymentMeans[cbc:PaymentMeansCode = (30,58)]"/>

  <param name="BG-18_PAYMENT_CARD_INFO" value="/ubl:Invoice/cac:PaymentMeans[cbc:PaymentMeansCode = (48,54,55)]"/>

  <param name="BG-19_DIRECT_DEBIT" value="/ubl:Invoice/cac:PaymentMeans[cbc:PaymentMeansCode = 59]"/>

  <param name="BG-23_VAT_BREAKDOWN" value="/ubl:Invoice/cac:TaxTotal/cac:TaxSubtotal"/>

</pattern>
