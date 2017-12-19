<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" queryBinding="xslt2">
    <title>XRechnung 1.1 - Schematron - UBL - CreditNote</title>
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
    <ns prefix="cn" uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"/>
    <ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"/>
    <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
    <phase id="XRechnung_1.1_model">
        <active pattern="UBL-model"/>
    </phase>
    
    
    
    <!--Suppressed abstract pattern model was here-->
    
    
    
    <!--Start pattern based on abstract model--><pattern id="UBL-model">
    <rule context="//cn:CreditNote">
        <assert test="cac:PaymentMeans" flag="fatal" id="BR-DE-1">[BR-DE-1] Eine Rechnung (INVOICE) muss Angaben zu "PAYMENT INSTRUCTIONS" (BG-16) enthalten.</assert>
        <assert test="cbc:BuyerReference" flag="fatal" id="BR-DE-15">[BR-DE-15] Das Element "Buyer reference" (BT-10) ist zwingend zu übermitteln.</assert>
        <assert test="(cac:TaxRepresentativeParty, cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID)" flag="fatal" id="BR-DE-16">[BR-DE-16] Das Element "Seller VAT identifier" (BT-31) ist anzugeben, wenn nicht das Element "Seller tax registration identifier" (BT-32) oder eine Gruppe "SELLER TAX REPRESENTATIVE PARTY" (BG-11) angegeben wurden.</assert>
        <assert test="cbc:CreditNoteTypeCode = '326' or cbc:CreditNoteTypeCode = '380' or cbc:CreditNoteTypeCode = '384' or cbc:CreditNoteTypeCode = '381'" flag="warning" id="BR-DE-17">[BR-DE-17] Mit dem Element "Invoice type code" (BT-3) sollen ausschließlich folgende Codes aus der Codeliste UNTDID 1001a übermittelt werden: 326 (Partial invoice), 380 (Commercial invoice), 384 (Corrected invoice) und 381 (Credit note).</assert>
        <assert test="every $line in tokenize(cac:PaymentTerms/cbc:Note,'\n\r?') satisfies if(count(tokenize($line,'#')) &gt; 1) then tokenize($line,'#')[1]='' and (tokenize($line,'#')[2]='SKONTO' or tokenize($line,'#')[2]='VERZUG') and string-length(replace(tokenize($line,'#')[3],'TAGE=[0-9]+',''))=0 and string-length(replace(tokenize($line,'#')[4],'PROZENT=[0-9]+\.[0-9]{2}',''))=0 and (tokenize($line,'#')[5]='' and empty(tokenize($line,'#')[6]) or string-length(replace(tokenize($line,'#')[5],'BASISBETRAG=[0-9]+\.[0-9]{2}',''))=0 and tokenize($line,'#')[6]='' and empty(tokenize($line,'#')[7])) else true()" flag="fatal" id="BR-DE-18">[BR-DE-18] Informationen zur Gewährung von Skonto oder zur Berechnung von Verzugszinsen müssen wie folgt im Element "Payment terms" (BT-20) jeweils in einer eigenen Zeile übermittelt werden: Anzugeben ist im ersten Segment "SKONTO" oder "VERZUG", im zweiten "TAGE=n", im dritten "PROZENT=n", wobei die Segmente jeweils von einer "#" umfasst sind. Prozentzahlen sind mit Punkt getrennt von zwei Nachkommastellen anzugeben. Liegt dem zu berechnenden Betrag nicht BT-115, "fälliger Betrag" zugrunde, sondern nur ein Teil des fälligen Betrags der Rechnung, ist der Grundwert zur Berechnung von Skonto oder Verzugszins als viertes Segment "BASISBETRAG=n" mit dem semantischen Datentyp Amount anzugeben.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:AccountingSupplierParty">
        <assert test="cac:Party/cac:Contact" flag="fatal" id="BR-DE-2">[BR-DE-2] Die Gruppe "SELLER CONTACT" (BG-6) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
        <assert test="cbc:CityName" flag="fatal" id="BR-DE-3">[BR-DE-3] Das Element "Seller city" (BT-37) ist zwingend zu übermitteln.</assert>
        <assert test="cbc:PostalZone" flag="fatal" id="BR-DE-4">[BR-DE-4] Das Element "Seller post code" (BT-38) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:Contact">
        <assert test="cbc:Name" flag="fatal" id="BR-DE-5">[BR-DE-5] Das Element "Seller contact point" (BT-41) ist zwingend zu übermitteln.</assert>
        <assert test="cbc:Telephone" flag="fatal" id="BR-DE-6">[BR-DE-6] Das Element "Seller contact telephone number" (BT-42) ist zwingend zu übermitteln.</assert>
        <assert test="cbc:ElectronicMail" flag="fatal" id="BR-DE-7">[BR-DE-7] Das Element "Seller contact email address" (BT-43) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
        <assert test="cbc:CityName" flag="fatal" id="BR-DE-8">[BR-DE-8] Das Element "Buyer city" (BT-52) ist zwingend zu übermitteln.</assert>
        <assert test="cbc:PostalZone" flag="fatal" id="BR-DE-9">[BR-DE-9] Das Element "Buyer post code" (BT-53) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address">
        <assert test="cbc:CityName" flag="fatal" id="BR-DE-10">[BR-DE-10] Das Element "Deliver to city" (BT-77) ist zwingend zu übermitteln.</assert>
        <assert test="cbc:PostalZone" flag="fatal" id="BR-DE-11">[BR-DE-11] Das Element "Deliver to post code" (BT-78) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:PaymentMeans">
        <assert test="count(cac:PayeeFinancialAccount[1]) + count(cac:CardAccount) + count(cac:PaymentMandate) = 1" flag="fatal" id="BR-DE-13">[BR-DE-13] In der Rechnung müssen Angaben zu einer der drei Gruppen "CREDIT TRANSFER" (BG-17), "PAYMENT CARD INFORMATION" (BG-18) oder "DIRECT DEBIT"(BG-19) gemacht werden.</assert>
    </rule>
    <rule context="//cn:CreditNote/cac:TaxTotal/cac:TaxSubtotal">
        <assert test="cac:TaxCategory/cbc:Percent" flag="fatal" id="BR-DE-14">[BR-DE-14] Das Element "VAT category rate" (BT-119) ist zwingend zu übermitteln.</assert>
    </rule>
</pattern>
    
    
</schema>