<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    queryBinding="xslt2">
    <title>Rules for UBL Billing - DE Validation.</title>
    <ns prefix="cbc"
        uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
    <ns prefix="cac"
        uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
    <ns prefix="ext"
        uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" />
    <ns prefix="cn"
        uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" />
    <ns prefix="ubl"
        uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" />
    <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
    <phase id="XRechnung_1.1_model">
        <active pattern="UBL-model" />
    </phase>
    <!--Suppressed abstract pattern model was here-->
    <!--Start pattern based on abstract model-->
    <pattern id="UBL-model">
        <rule context="//ubl:Invoice">
            <assert test="cac:PaymentMeans" flag="fatal" id="DE-R-1">For German suppliers, an invoice must contain information on “PAYMENT INTSTRUCTIONS” (BG-16).</assert>
            <assert
                test="count((cac:PaymentMeans/cac:PayeeFinancialAccount)[1]) + count(cac:PaymentMeans/cac:CardAccount) + count(cac:PaymentMeans/cac:PaymentMandate) = 1"
                flag="fatal" id="DE-R-13">For German suppliers, an invoice must contain information either on „CREDIT TRANSFER“ (BG-17) or „PAYMENT CARD INFORMATION“ (BG-18) or „DIRECT DEBIT“ (BG-19).</assert>
            <assert test="cbc:BuyerReference[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-15">For German suppliers, the element “Buyer reference“ (BT-10) must be provided.</assert>
            <assert
                test="(cac:TaxRepresentativeParty, cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID[boolean(normalize-space(.))])"
                flag="fatal" id="DE-R-16">For German suppliers, an invoice must contain at least one of the following elements: “Seller VAT identifier“ (BT-31) or “Seller tax registration identifier“ (BT-32) or “SELLER TAX REPRESENTATIVE PARTY“ (BG-11).</assert>
            <assert
                test="cbc:InvoiceTypeCode = ('326', '380', '384', '389', '381')"
                flag="warning" id="DE-R-17">For German suppliers, the element “Invoice type code” (BT-3) should only contain the following values from code list UNTDID 1001: 326 (Partial invoice),
                380 (Commercial invoice), 384 (Corrected invoice), 389
                (Self-billed invoice) und 381 (Credit note).</assert>
            <assert
                test="
                    every $line in cac:PaymentTerms/cbc:Note/tokenize(., '(\r\n|\r|\n)')
                        satisfies if (count(tokenize($line, '#')) &gt; 1) then
                            tokenize($line, '#')[1] = '' and (tokenize($line, '#')[2] = 'SKONTO' or tokenize($line, '#')[2] = 'VERZUG') and string-length(replace(tokenize($line, '#')[3], 'TAGE=[0-9]+', '')) = 0 and string-length(replace(tokenize($line, '#')[4], 'PROZENT=[0-9]+\.[0-9]{2}', '')) = 0 and (tokenize($line, '#')[5] = '' and empty(tokenize($line, '#')[6]) or string-length(replace(tokenize($line, '#')[5], 'BASISBETRAG=[0-9]+\.[0-9]{2}', '')) = 0 and tokenize($line, '#')[6] = '' and empty(tokenize($line, '#')[7]))
                        else
                            true()"
                            flag="fatal" id="DE-R-18">For German suppliers, information on cash discount for prompt payment (Skonto) or default charges (Verzugszinsen) must be provided within the element “Payment terms” BT-20 in the following way: 
                First segment “SKONTO” or “VERZUG”, second segment amount of days (“TAGE=N”), third segment percentage (“PROZENT=N”). Percentage must be separated by dot with two decimal places.  In case the base value of the invoiced amount is not provided in BT-115 but as partial amount, the base value must be provided as fourth segment “BASISBETRAG=N” as semantic data type amount. 
                Each entry must start with a #, the segments must be separated by # and a row must end with a #. A complete statement on cash discount for prompt payment or default charges must end with a XML-conformant line break. 
                All statements on cash discount for prompt payment or default charges must be given in capital letters. Additional whitespaces (blanks, tabulators or line breaks) are not allowed. Other characters or texts than defined above are not allowed.</assert>
        </rule>
        <rule context="//ubl:Invoice/cac:AccountingSupplierParty">
            <assert test="cac:Party/cac:Contact" flag="fatal" id="DE-R-2"
                >For German suppliers, the group “SELLER CONTACT” (BG-6) must be provided.</assert>
        </rule>
        <rule
            context="//ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
            <assert test="cbc:CityName[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-3">For German suppliers, the element “seller city” (BT-37) must be provided.</assert>
            <assert test="cbc:PostalZone[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-4">For German suppliers, the element “Seller post code“ (BT-38) must be provided.</assert>
        </rule>
        <rule
            context="//ubl:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact">
            <assert test="cbc:Name[boolean(normalize-space(.))]" flag="fatal"
                id="DE-R-5">For German suppliers, the element “Seller contact point“ (BT-41) must be provided. </assert>
            <assert test="cbc:Telephone[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-6">For German suppliers, the element “Seller contact telephone number“ (BT-42) must be provided.</assert>
            <assert test="cbc:ElectronicMail[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-7">For German suppliers, the element “Seller contact email address“ (BT-43) must be provided.</assert>
        </rule>
        <rule
            context="//ubl:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
            <assert test="cbc:CityName[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-8">For German suppliers, the element “Buyer city“ (BT-52) must be provided.</assert>
            <assert test="cbc:PostalZone[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-9">For German suppliers, the element “Buyer post code“ (BT-53) must be provided.</assert>
        </rule>
        <rule
            context="//ubl:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address">
            <assert test="cbc:CityName[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-10">For German suppliers, the element “Deliver to city“ (BT-77) must be provided if the Group „DELIVER TO ADDRESS“ (BG-15) is delivered.</assert>
            <assert test="cbc:PostalZone[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-11">For German suppliers, the element „Deliver to post code“ (BT-78) must be provided if the Group „DELIVER TO ADDRESS“ (BG-15) is delivered.</assert>
        </rule>
        <rule context="//ubl:Invoice/cac:TaxTotal/cac:TaxSubtotal">
            <assert
                test="cac:TaxCategory/cbc:Percent[boolean(normalize-space(.))]"
                flag="fatal" id="DE-R-14">For German suppliers, the element “VAT category rate “ (BT-119) must be provided.</assert>
        </rule>
    </pattern>
</schema>
