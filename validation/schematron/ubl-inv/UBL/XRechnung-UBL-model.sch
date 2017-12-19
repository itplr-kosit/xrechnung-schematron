<pattern xmlns="http://purl.oclc.org/dsdl/schematron" is-a="model" id="UBL-model">
    <param name="BR-DE-1 " value="cac:PaymentMeans"/>
    <param name="BR-DE-2" value="cac:Party/cac:Contact"/>
    <param name="BR-DE-3" value="cbc:CityName"/>
    <param name="BR-DE-4" value="cbc:PostalZone"/>
    <param name="BR-DE-5" value="cbc:Name"/>
    <param name="BR-DE-6" value="cbc:Telephone"/>
    <param name="BR-DE-7" value="cbc:ElectronicMail"/>
    <param name="BR-DE-8" value="cbc:CityName"/>
    <param name="BR-DE-9" value="cbc:PostalZone"/>
    <param name="BR-DE-10" value="cbc:CityName"/>
    <param name="BR-DE-11" value="cbc:PostalZone"/>
    <param name="BR-DE-13" value="count(cac:PayeeFinancialAccount[1]) + count(cac:CardAccount) + count(cac:PaymentMandate) = 1"/>
    <param name="BR-DE-14" value="cac:TaxCategory/cbc:Percent"/>
    <param name="BR-DE-15" value="cbc:BuyerReference"/>
    <param name="BR-DE-16" value="(cac:TaxRepresentativeParty, cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID)"/>
    <param name="BR-DE-17" value="cbc:InvoiceTypeCode = '326' or cbc:InvoiceTypeCode = '380' or cbc:InvoiceTypeCode = '384' or cbc:InvoiceTypeCode = '381'"/>
    <param name="BR-DE-18" value="every $line in tokenize(cac:PaymentTerms/cbc:Note,'\n\r?') satisfies if(count(tokenize($line,'#')) &gt; 1) then tokenize($line,'#')[1]='' and (tokenize($line,'#')[2]='SKONTO' or tokenize($line,'#')[2]='VERZUG') and string-length(replace(tokenize($line,'#')[3],'TAGE=[0-9]+',''))=0 and string-length(replace(tokenize($line,'#')[4],'PROZENT=[0-9]+\.[0-9]{2}',''))=0 and (tokenize($line,'#')[5]='' and empty(tokenize($line,'#')[6]) or string-length(replace(tokenize($line,'#')[5],'BASISBETRAG=[0-9]+\.[0-9]{2}',''))=0 and tokenize($line,'#')[6]='' and empty(tokenize($line,'#')[7])) else true()"/>

    <param name="INVOICE" value="//ubl:Invoice"/>
    <param name="BG-4_SELLER" value="//ubl:Invoice/cac:AccountingSupplierParty"/>
    <param name="BG-5_SELLER_POSTAL_ADDRESS" value="//ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"/>
    <param name="BG-6_SELLER_CONTACT" value="//ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact"/>

    <param name="BG-8_BUYER_POSTAL_ADDRESS" value="//ubl:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"/>

    <param name="BG-15_DELIVER_TO_ADDRESS" value="//ubl:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address"/>

    <param name="BG-16_PAYMENT_INSTRUCTIONS" value="//ubl:Invoice/cac:PaymentMeans"/>

    <param name="BG-23_VAT_BREAKDOWN" value="//ubl:Invoice/cac:TaxTotal/cac:TaxSubtotal"/>

</pattern>
