<pattern xmlns="http://purl.oclc.org/dsdl/schematron" abstract="true" id="model">
    <rule context="$CREDIT_NOTE">
        <assert test="$BR-DE-1 " flag="fatal" id="BR-DE-1">[BR-DE-1] Eine Rechnung (INVOICE) muss Angaben zu "PAYMENT INSTRUCTIONS" (BG-16) enthalten.</assert>
        <assert test="$BR-DE-13" flag="fatal" id="BR-DE-13">[BR-DE-13] In der Rechnung müssen Angaben zu einer der drei Gruppen "CREDIT TRANSFER" (BG-17), "PAYMENT CARD INFORMATION" (BG-18) oder "DIRECT DEBIT" (BG-19) übermittelt werden.</assert>
        <assert test="$BR-DE-15" flag="fatal" id="BR-DE-15">[BR-DE-15] Das Element "Buyer reference" (BT-10) muss übermittelt werden.</assert>
        <assert test="$BR-DE-16" flag="fatal" id="BR-DE-16">[BR-DE-16] In der Rechnung muss mindestens eines der Elemente „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „SELLER TAX REPRESENTATIVE PARTY“ (BG-11) übermittelt werden.</assert>
        <assert test="$BR-DE-17" flag="warning" id="BR-DE-17">[BR-DE-17] Mit dem Element "Invoice type code" (BT-3) sollen ausschließlich folgende Codes aus der Codeliste UNTDID 1001 übermittelt werden: 326 (Partial invoice), 380 (Commercial invoice), 384 (Corrected invoice) und 381 (Credit note).</assert>
        <assert test="$BR-DE-18" flag="fatal" id="BR-DE-18">[BR-DE-18] Informationen zur Gewährung von Skonto oder zur Berechnung von Verzugszinsen müssen wie folgt im Element "Payment terms" (BT-20) jeweils in einer eigenen Zeile übermittelt werden: Anzugeben ist im ersten Segment "SKONTO" oder "VERZUG", im zweiten "TAGE=n", im dritten "PROZENT=n", wobei die Segmente jeweils von einer "#" umfasst sind. Prozentzahlen sind mit Punkt getrennt von zwei Nachkommastellen anzugeben. Liegt dem zu berechnenden Betrag nicht BT-115, "fälliger Betrag" zugrunde, sondern nur ein Teil des fälligen Betrags der Rechnung, ist der Grundwert zur Berechnung von Skonto oder Verzugszins als viertes Segment "BASISBETRAG=n" mit dem semantischen Datentyp Amount anzugeben.</assert>
    </rule>
    <rule context="$BG-4_SELLER">
        <assert test="$BR-DE-2" flag="fatal" id="BR-DE-2">[BR-DE-2] Die Gruppe "SELLER CONTACT" (BG-6) muss übermittelt werden.</assert>
    </rule>
    <rule context="$BG-5_SELLER_POSTAL_ADDRESS">
        <assert test="$BR-DE-3" flag="fatal" id="BR-DE-3">[BR-DE-3] Das Element "Seller city" (BT-37) muss übermittelt werden.</assert>
        <assert test="$BR-DE-4" flag="fatal" id="BR-DE-4">[BR-DE-4] Das Element "Seller post code" (BT-38) muss übermittelt werden.</assert>
    </rule>
    <rule context="$BG-6_SELLER_CONTACT">
        <assert test="$BR-DE-5" flag="fatal" id="BR-DE-5">[BR-DE-5] Das Element "Seller contact point" (BT-41) muss übermittelt werden.</assert>
        <assert test="$BR-DE-6" flag="fatal" id="BR-DE-6">[BR-DE-6] Das Element "Seller contact telephone number" (BT-42) muss übermittelt werden.</assert>
        <assert test="$BR-DE-7" flag="fatal" id="BR-DE-7">[BR-DE-7] Das Element "Seller contact email address" (BT-43) muss übermittelt werden.</assert>
    </rule>
    <rule context="$BG-8_BUYER_POSTAL_ADDRESS">
        <assert test="$BR-DE-8" flag="fatal" id="BR-DE-8">[BR-DE-8] Das Element "Buyer city" (BT-52) muss übermittelt werden.</assert>
        <assert test="$BR-DE-9" flag="fatal" id="BR-DE-9">[BR-DE-9] Das Element "Buyer post code" (BT-53) muss übermittelt werden.</assert>
    </rule>
    <rule context="$BG-15_DELIVER_TO_ADDRESS">
        <assert test="$BR-DE-10" flag="fatal" id="BR-DE-10">[BR-DE-10] Das Element "Deliver to city" (BT-77) muss übermittelt werden.</assert>
        <assert test="$BR-DE-11" flag="fatal" id="BR-DE-11">[BR-DE-11] Das Element "Deliver to post code" (BT-78) muss übermittelt werden.</assert>
    </rule>
    <rule context="$BG-23_VAT_BREAKDOWN">
        <assert test="$BR-DE-14" flag="fatal" id="BR-DE-14">[BR-DE-14] Das Element "VAT category rate" (BT-119) muss übermittelt werden.</assert>
    </rule>
</pattern>
