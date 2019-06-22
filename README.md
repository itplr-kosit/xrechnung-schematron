# XRechnung Schematron

Technical implementation of the German CIUS (XRechnung) business rules for EN16931:2017 as Schematron Rules for XML validation.

## Releases

You can find packaged [releases on our GitHub project](https://github.com/itplr-kosit/xrechnung-schematron/releases)

## Semantic Versioning

Since December 2018 we introduced [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Given a version number MAJOR.MINOR.PATCH, we increment the:

1. MAJOR version when we make incompatible changes:
    * That is we introduce changes to the rules which will **DEFINITELY** not validate previously generated XML which was valid to previous major version anymore
1. MINOR version when we add functionality
    * That is we introduce changes to the rules which widen the scope of valid content (e.g. we add new codelist terms or accept new optional XML elements).
    * **CAUTION**: This might break YOUR validation scenario and ability to accept XML content
1. PATCH version when we make backwards-compatible bug fixes.

## Technical Coverage of the National Business Rules in the Validation Artefacts

ID | German Description | Coverage
--- | --- | ---
BR-DE-1 | Eine Rechnung (INVOICE) muss Angaben zu „PAYMENT INSTRUCTIONS“ (BG-16) enthalten. | complete (Schematron)
BR-DE-2 | Die Gruppe „SELLER CONTACT“ (BG-6) muss übermittelt werden. | complete (Schematron)
BR-DE-3 | Das Element „Seller city“ (BT-37) muss übermittelt werden. | complete (Schematron)
BR-DE-4 | Das Element „Seller post code“ (BT-38) muss übermittelt werden. | complete (Schematron)
BR-DE-5 | Das Element „Seller contact point“ (BT-41) muss übermittelt werden. | complete (Schematron)
BR-DE-6 | Das Element „Seller contact telephone number“ (BT-42) muss übermittelt werden. | complete (Schematron)
BR-DE-7 | Das Element „Seller contact email address“ (BT-43) muss übermittelt werden. | complete (Schematron)
BR-DE-8 | Das Element „Buyer city“ (BT-52) muss übermittelt werden. | complete (Schematron)
BR-DE-9 | Das Element „Buyer post code“ (BT-53) muss übermittelt werden. | complete (Schematron)
BR-DE-10 | Das Element „Deliver to city“ (BT-77) muss übermittelt werden, wenn die Gruppe „DELIVER TO ADDRESS“ (BG-15) übermittelt wird. | complete (Schematron)
BR-DE-11 | Das Element „Deliver to post code“ (BT-78) muss übermittelt werden, wenn die Gruppe „DELIVER TO ADDRESS“ (BG-15) übermittelt wird. | complete (Schematron)
BR-DE-12 | Mit dem Element „Deliver to post code“ (BT-78) muss eine Postleitzahl übermittelt werden. | none
BR-DE-13 | In der Rechnung müssen Angaben zu genau einer der drei Gruppen „CREDIT TRANSFER“ (BG-17), „PAYMENT CARD INFORMATION“ (BG-18) oder „DIRECT DEBIT“ (BG-19) übermittelt werden. | complete (Schematron)
BR-DE-14 | Das Element „VAT category rate“ (BT-119) muss übermittelt werden. | complete (Schematron)
BR-DE-15 | Das Element „Buyer reference“ (BT-10) muss übermittelt werden. | complete (Schematron)
BR-DE-16 | In der Rechnung muss mindestens eines der Elemente „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „SELLER TAX REPRESENTATIVE PARTY“ (BG-11) übermittelt werden. | complete (Schematron)
BR-DE-17 | Mit dem Element „Invoice type code“ (BT-3) sollen ausschließlich folgende Codes aus der Codeliste UNTDID 1001 (United Nations Trade Data Interchange Directory (UNTDID), http://www.unece.org/fileadmin/DAM/trade/untdid/d16b/tred/tredi2.htm) übermittelt werden: | complete (Schematron)
| | - 326 (Partial invoice) |
| | - 380 (Commercial invoice) |
| | - 384 (Corrected invoice) |
| | - 389 (Self-billed invoice) |
| | - 381 (Credit note) | |
BR-DE-18 | Die Informationen zur Gewährung von Skonto oder zur Berechnung von Verzugszinsen müssen wie folgt im Element „Payment terms“ (BT-20) übermittelt werden: | complete (Schematron)
| | Anzugeben ist im ersten Segment „SKONTO“ oder „VERZUG“, im zweiten „TAGE=n“, im dritten „PROZENT=n“. Prozentzahlen sind ohne Vorzeichen sowie mit Punkt getrennt von zwei Nachkommastellen anzugeben. Liegt dem zu berechnenden Betrag nicht BT-115, „fälliger Betrag“ zugrunde, sondern nur ein Teil des fälligen Betrags der Rechnung, ist der Grundwert zur Berechnung von Skonto oder Verzugszins als viertes Segment „BASISBETRAG=n“ gemäß dem semantischen Datentypen Amount anzugeben. | 
| | Jeder Eintrag beginnt mit einer #, die Segmente sind mit einer # getrennt und eine Zeile schließt mit einer # ab. Am Ende einer vollständigen Skontooder Verzugsangabe muss ein XML-konformer Zeilenumbruch folgen. |
| | Alle Angaben zur Gewährung von Skonto oder zur Berechnung von Verzugszinsen müssen in Großbuchstaben gemacht werden. Zusätzliches Whitespace (Leerzeichen, Tabulatoren oder Zeilenumbrüche) ist nicht zulässig. Andere Zeichen oder Texte als in den oberen Vorgaben genannt sind nicht zulässig. |
