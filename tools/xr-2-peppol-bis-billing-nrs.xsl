<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:ubl-creditnote="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:ubl-invoice="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:a="assert"
    xmlns:v="variable"
    xpath-default-namespace="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs math a v sch ubl-invoice ubl-creditnote"
    version="3.0">
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
    
    <xsl:output indent="true"/>
    
    <!-- List of BRs to be integrated -->
    <xsl:variable name="asserts" as="xs:string *">        
        <xsl:for-each select="document('xr-rules-list.xml')/*/a:assert[not(@exclude)]/@key">
            <xsl:value-of select="."/>
        </xsl:for-each>        
    </xsl:variable>
    
    <xsl:variable name="commons" as="xs:string *">
        <xsl:for-each select="document('xr-variables-list.xml')/*/v:variable">
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates select="ns" />
            <xsl:apply-templates select="pattern[@id='ubl-pattern']"/>
        </xsl:copy> 
    </xsl:template>
    
    <xsl:template match="ns">
        <xsl:copy select=".">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    
    <!-- copy ubl-pattern only -->
    <xsl:template match="pattern[@id='ubl-pattern']">
        
        <pattern>
        
        <!-- set DESupplierCountry and DECustomerCountry -->    
        <let name="supplierCountryIsDE" value="(upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode)) = 'DE')" />
        <xsl:text>&#xa;  </xsl:text>
        <let name="customerCountryIsDE" value="(upper-case(normalize-space(/*/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode)) = 'DE')" />
        <xsl:text>&#xa;  </xsl:text>
        
        <!-- include variables needed from common.sch -->
        <xsl:apply-templates select="document('../src/validation/schematron/common.sch')/pattern/let"/>

        <xsl:apply-templates select="rule"/>
      
        </pattern>
    </xsl:template>
    
    <xsl:template match="rule">
        
        <xsl:apply-templates select="rule/let"/>
        
        <!-- exclude rules not needed in NRS -->
        <xsl:if test="./assert/@id=$asserts">            
            <xsl:copy select=".">
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates/>
            </xsl:copy>    
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="rule/@context">
        <!-- TODO -->
        <xsl:variable name="supplier-customer" select='"[\$supplierCountryIsDE and \$customerCountryIsDE]"'/>
        <xsl:variable name="invoice-ns" select="concat('ubl-invoice:Invoice', $supplier-customer)"/>
        <xsl:variable name="creditnote-ns" select="concat('ubl-creditnote:CreditNote', $supplier-customer)"/>
    
        <xsl:variable name="invoice-path" select="normalize-space(substring-before(replace(., 'ubl:Invoice', $invoice-ns), '|'))"/>  
        <xsl:variable name="creditnote-path" select="normalize-space(substring-after(replace(., 'cn:CreditNote', $creditnote-ns), '|'))"/>
        <xsl:variable name="inv-and-cn-path" select='$invoice-path || " | " || $creditnote-path'/>
        <xsl:attribute name="context">
            <xsl:value-of select="$inv-and-cn-path"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- translate XR rule ids and texts to peppol rule ids and texts -->
    <xsl:template match="assert">
        <xsl:if test="@id=$asserts">
            <xsl:variable name="rule-id" select="./@id"/>
            <xsl:copy>
                <xsl:apply-templates select="@*"/>
                <xsl:attribute name="id">
                    <xsl:value-of select="document('xr-rules-list.xml')/*/a:assert[@key = $rule-id]/@id"/>
                </xsl:attribute>
                <xsl:value-of select="document('xr-rules-list.xml')/*/a:assert[@key = $rule-id]"/>
            </xsl:copy> 
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="pattern/let">
        <xsl:if test="./not(@name=$commons)">
            <xsl:copy select=".">
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates />
            </xsl:copy>
        </xsl:if>  
    </xsl:template>
    
    <xsl:template match="rule/let">
        <xsl:copy select=".">
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>