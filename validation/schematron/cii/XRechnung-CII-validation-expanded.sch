<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" xmlns:ccts="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2" xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100" xmlns:qdt="urn:un:unece:uncefact:data:standard:QualifiedDataType:100" xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" queryBinding="xslt2">
    <title>XRechnung 1.1 - Schematron - CII</title>
    <ns prefix="rsm" uri="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"/>
    <ns prefix="ccts" uri="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2"/>
    <ns prefix="udt" uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100"/>
    <ns prefix="qdt" uri="urn:un:unece:uncefact:data:standard:QualifiedDataType:100"/>
    <ns prefix="ram" uri="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"/>
    <phase id="XRechnung_1.1_model">
        <active pattern="CII-model"/>
    </phase>
    
    
    
    <!--Suppressed abstract pattern model was here-->
    
    
    
    <!--Start pattern based on abstract model--><pattern id="CII-model">
    <rule context="//rsm:CrossIndustryInvoice">
        <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans" flag="fatal" id="BR-DE-1">[BR-DE-1] Eine Rechnung (INVOICE) muss Angaben zu "PAYMENT INSTRUCTIONS" (BG-16) enthalten.</assert>
        <assert test="count((rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount)[1]) + count(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard) + count((rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID, rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID, rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID)[1]) = 1" flag="fatal" id="BR-DE-13">[BR-DE-13] In der Rechnung müssen Angaben zu einer der drei Gruppen "CREDIT TRANSFER" (BG-17), "PAYMENT CARD INFORMATION" (BG-18) oder "DIRECT DEBIT"(BG-19) gemacht werden.</assert>
        <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerReference" flag="fatal" id="BR-DE-15">[BR-DE-15] Das Element "Buyer reference" (BT-10) ist zwingend zu übermitteln.</assert>
        <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID='VA' or @schemeID='FC'], rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty)" flag="fatal" id="BR-DE-16">[BR-DE-16] Das Element "Seller VAT identifier" (BT-31) ist anzugeben, wenn nicht das Element "Seller tax registration identifier" (BT-32) oder eine Gruppe "SELLER TAX REPRESENTATIVE PARTY" (BG-11) angegeben wurden.</assert>
        <assert test="rsm:ExchangedDocument/ram:TypeCode = '326' or rsm:ExchangedDocument/ram:TypeCode = '380' or rsm:ExchangedDocument/ram:TypeCode = '384' or rsm:ExchangedDocument/ram:TypeCode = '381'" flag="warning" id="BR-DE-17">[BR-DE-17] Mit dem Element "Invoice type code" (BT-3) sollen ausschließlich folgende Codes aus der Codeliste UNTDID 1001a übermittelt werden: 326 (Partial invoice), 380 (Commercial invoice), 384 (Corrected invoice) und 381 (Credit note).</assert>
        <assert test="every $line in tokenize(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:Description,'\n\r?') satisfies if(count(tokenize($line,'#')) &gt; 1) then tokenize($line,'#')[1]='' and (tokenize($line,'#')[2]='SKONTO' or tokenize($line,'#')[2]='VERZUG') and string-length(replace(tokenize($line,'#')[3],'TAGE=[0-9]+',''))=0 and string-length(replace(tokenize($line,'#')[4],'PROZENT=[0-9]+\.[0-9]{2}',''))=0 and (tokenize($line,'#')[5]='' and empty(tokenize($line,'#')[6]) or string-length(replace(tokenize($line,'#')[5],'BASISBETRAG=[0-9]+\.[0-9]{2}',''))=0 and tokenize($line,'#')[6]='' and empty(tokenize($line,'#')[7])) else true()" flag="fatal" id="BR-DE-18">[BR-DE-18] Informationen zur Gewährung von Skonto oder zur Berechnung von Verzugszinsen müssen wie folgt im Element "Payment terms" (BT-20) jeweils in einer eigenen Zeile übermittelt werden: Anzugeben ist im ersten Segment "SKONTO" oder "VERZUG", im zweiten "TAGE=n", im dritten "PROZENT=n", wobei die Segmente jeweils von einer "#" umfasst sind. Prozentzahlen sind mit Punkt getrennt von zwei Nachkommastellen anzugeben. Liegt dem zu berechnenden Betrag nicht BT-115, "fälliger Betrag" zugrunde, sondern nur ein Teil des fälligen Betrags der Rechnung, ist der Grundwert zur Berechnung von Skonto oder Verzugszins als viertes Segment "BASISBETRAG=n" mit dem semantischen Datentyp Amount anzugeben.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
        <assert test="ram:DefinedTradeContact" flag="fatal" id="BR-DE-2">[BR-DE-2] Die Gruppe "SELLER CONTACT" (BG-6) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
        <assert test="ram:CityName" flag="fatal" id="BR-DE-3">[BR-DE-3] Das Element "Seller city" (BT-37) ist zwingend zu übermitteln.</assert>
        <assert test="ram:PostcodeCode" flag="fatal" id="BR-DE-4">[BR-DE-4] Das Element "Seller post code" (BT-38) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact">
        <assert test="ram:PersonName" flag="fatal" id="BR-DE-5">[BR-DE-5] Das Element "Seller contact point" (BT-41) ist zwingend zu übermitteln.</assert>
        <assert test="ram:TelephoneUniversalCommunication/ram:CompleteNumber" flag="fatal" id="BR-DE-6">[BR-DE-6] Das Element "Seller contact telephone number" (BT-42) ist zwingend zu übermitteln.</assert>
        <assert test="ram:EmailURIUniversalCommunication/ram:URIID" flag="fatal" id="BR-DE-7">[BR-DE-7] Das Element "Seller contact email address" (BT-43) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress">
        <assert test="ram:CityName" flag="fatal" id="BR-DE-8">[BR-DE-8] Das Element "Buyer city" (BT-52) ist zwingend zu übermitteln.</assert>
        <assert test="ram:PostcodeCode" flag="fatal" id="BR-DE-9">[BR-DE-9] Das Element "Buyer post code" (BT-53) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress">
        <assert test="ram:CityName" flag="fatal" id="BR-DE-10">[BR-DE-10] Das Element "Deliver to city" (BT-77) ist zwingend zu übermitteln.</assert>
        <assert test="ram:PostcodeCode" flag="fatal" id="BR-DE-11">[BR-DE-11] Das Element "Deliver to post code" (BT-78) ist zwingend zu übermitteln.</assert>
    </rule>
    <rule context="//rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
        <assert test="ram:RateApplicablePercent" flag="fatal" id="BR-DE-14">[BR-DE-14] Das Element "VAT category rate" (BT-119) ist zwingend zu übermitteln.</assert>
    </rule>
</pattern>
    
    
</schema>