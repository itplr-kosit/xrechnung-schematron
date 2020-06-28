<?xml version="1.0" encoding="UTF-8"?>

<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"
    xmlns:ccts="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2"
    xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100"
    xmlns:qdt="urn:un:unece:uncefact:data:standard:QualifiedDataType:100"
    xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"
    schemaVersion="2.0.0" queryBinding="xslt2">
    <title>Schematron Version @xr-schematron.version.full@ - XRechnung
        @xrechnung.version@ compatible - CII</title>
    <ns prefix="rsm"
        uri="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" />
    <ns prefix="ccts"
        uri="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2" />
    <ns prefix="udt"
        uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100" />
    <ns prefix="qdt"
        uri="urn:un:unece:uncefact:data:standard:QualifiedDataType:100" />
    <ns prefix="ram"
        uri="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" />
    
    <phase id="XRechnung_model">
        <active pattern="CII-model" />
        <active pattern="cii-extension-pattern" />
    </phase>

    <!-- Abstract CEN BII patterns -->
    <!-- ========================= -->
    <include href="abstract/XRechnung-model.sch" />

    <!-- Data Binding parameters -->
    <!-- ======================= -->
    <include href="CII/XRechnung-CII-model.sch" />
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
        id="cii-extension-pattern">
        <rule
            context="/rsm:CrossIndustryInvoice[rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID = 'urn:cen.eu:en16931:2017#compliant#urn:xoev-de:kosit:standard:xrechnung_2.0#conformant#urn:xoev-de:kosit:extension:xrechnung_2.0']">
            <!-- BR-DEX-01
        checks whether an EmbeddedCocumentBinaryObject has a valid mimeCode (incl. XML)
        -->
            <assert
                test="//ram:AttachmentBinaryObject[@mimeCode = 'application/pdf' or @mimeCode = 'image/png' or @mimeCode = 'image/jpeg' or @mimeCode = 'text/csv' or @mimeCode = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' or @mimeCode = 'application/vnd.oasis.opendocument.spreadsheet' or @mimeCode = 'application/xml']"
                id="BR-DEX-01" flag="fatal"
                >[BR-DEX-01] Das Element "Attached Document" (BT-125) benutzt einen nicht zulässigen MIME-Code.</assert>            
        </rule>
    </pattern>

</schema>
