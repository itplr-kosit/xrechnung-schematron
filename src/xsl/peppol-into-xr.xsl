<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://purl.oclc.org/dsdl/schematron"    
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:ubl-creditnote="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:ubl-invoice="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:r="rule">
    <xsl:output indent="true"/>
    <xsl:param name="syntax"/>
    <!-- List of rules to be integrated -->    
    <xsl:variable name="rules" as="xs:string *" select="document('rule-list.xml')/*/r:rule/string(.)"/>     
    
    <xsl:template match="/">    
        <xsl:apply-templates mode="xrechung-rules"/>
    </xsl:template>
    
    <!-- Add peppol pattern to phase-->
    <xsl:template match="/*/phase" mode="xrechung-rules" priority="1">        
        <xsl:copy select=".">
            <xsl:apply-templates select="@*" mode="xrechung-rules"/>
            <xsl:apply-templates mode="xrechung-rules"/>
            <xsl:if test="$syntax='UBL'">
                <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/pattern" mode="xrechnung-rules"/>
            </xsl:if>
            <xsl:if test="$syntax='CII'">
                <!-- Add phase for R008 in CII -->                 
                <xsl:element name="active" namespace="{namespace-uri()}">
                    <xsl:attribute name="pattern">
                        <xsl:text>peppol-cii-pattern-0-a</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <!-- Add phase for R044 and R046 in CII -->                 
                <xsl:element name="active" namespace="{namespace-uri()}">
                    <xsl:attribute name="pattern">
                        <xsl:text>peppol-cii-pattern-0-b</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-CII.sch')/*/pattern" mode="xrechnung-rules"/>                
            </xsl:if>
        </xsl:copy> 
    </xsl:template>    
    <!-- Adds global lets and utility namespace from PEPPOL --> 
    <xsl:template match="/*/ns[last()]" mode="xrechung-rules" priority="1">               
        <xsl:copy-of select="."/>
        <xsl:element name="ns" namespace="{namespace-uri()}">
            <xsl:attribute name="uri">utils</xsl:attribute>
            <xsl:attribute name="prefix">u</xsl:attribute>
        </xsl:element>
        <xsl:comment>BEGIN Parameters from PEPPOL</xsl:comment>
        <xsl:if test="$syntax='UBL'">
            <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/let" mode="peppol-rules"/>
        </xsl:if>
        <xsl:if test="$syntax='CII'">
            <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-CII.sch')/*/let" mode="peppol-rules"/>
        </xsl:if>
        <xsl:comment>END Parameters from PEPPOL</xsl:comment>          
    </xsl:template>
    <xsl:template match="/*/include" mode="xrechung-rules" priority="1">
        <xsl:copy-of select="."/>
        <xsl:comment>BEGIN Functions from PEPPOL</xsl:comment>
        <xsl:if test="$syntax='UBL'">
            <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/xsl:function" mode="peppol-rules"/>
        </xsl:if>
        <xsl:if test="$syntax='CII'">
            <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-CII.sch')/*/xsl:function" mode="peppol-rules"/>
        </xsl:if>
        <xsl:comment>END Functions from PEPPOL</xsl:comment>
    </xsl:template>
    <xsl:template match="/*/pattern[@id='ubl-pattern']" mode="xrechung-rules" priority="1">        
        <xsl:comment>BEGIN Pattern from PEPPOL</xsl:comment>
        <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/pattern" mode="peppol-rules">
            <xsl:with-param name="syntax" select="'ubl'"/>
        </xsl:apply-templates>
        <xsl:comment>END Pattern from PEPPOL</xsl:comment>
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="/*/pattern[@id='cii-pattern']" mode="xrechung-rules" priority="1">
        <xsl:comment>BEGIN Pattern from PEPPOL</xsl:comment>
        <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-CII.sch')/*/pattern" mode="peppol-rules">
            <xsl:with-param name="syntax" select="'cii'"/>
        </xsl:apply-templates>
        <!-- add R008 to CII -->        
        <xsl:element name="pattern" namespace="{namespace-uri()}">
            <xsl:attribute name="id">peppol-cii-pattern-0-a</xsl:attribute>
            <xsl:element name="rule" namespace="{namespace-uri()}">
                <xsl:attribute name="context">//*[not(name() = 'ram:ApplicableHeaderTradeDelivery') and not(*) and not(normalize-space())]</xsl:attribute>
                <xsl:element name="assert" namespace="{namespace-uri()}">
                    <xsl:attribute name="id">PEPPOL-EN16931-R008</xsl:attribute>
                    <xsl:attribute name="test">false()</xsl:attribute>
                    <xsl:attribute name="flag">warning</xsl:attribute>
                    <xsl:text>Document MUST not contain empty elements.</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:element>  
        <!-- add R044 and R46 to CII -->        
        <xsl:element name="pattern" namespace="{namespace-uri()}">
            <xsl:attribute name="id">peppol-cii-pattern-0-b</xsl:attribute>            
            <xsl:element name="rule" namespace="{namespace-uri()}">
                <xsl:attribute name="context">rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice</xsl:attribute>
                <!-- R044 -->
                <xsl:element name="assert" namespace="{namespace-uri()}">
                    <xsl:attribute name="id">PEPPOL-EN16931-R044</xsl:attribute>
                    <xsl:attribute name="test">not(ram:AppliedTradeAllowanceCharge/ram:ActualAmount) or ram:AppliedTradeAllowanceCharge/ram:ChargeIndicator/udt:Indicator = 'false'</xsl:attribute>
                    <xsl:attribute name="flag">warning</xsl:attribute>
                    <xsl:text>Charge on price level is NOT allowed. Only value 'false' allowed.</xsl:text>
                </xsl:element>
                <!-- R046 -->
                <xsl:element name="assert" namespace="{namespace-uri()}">
                    <xsl:attribute name="id">PEPPOL-EN16931-R046</xsl:attribute>
                    <xsl:attribute name="test">not(ram:ChargeAmount) or xs:decimal(../ram:NetPriceProductTradePrice/ram:ChargeAmount) = xs:decimal(ram:ChargeAmount) - u:decimalOrZero(ram:AppliedTradeAllowanceCharge/ram:ActualAmount)</xsl:attribute>
                    <xsl:attribute name="flag">warning</xsl:attribute>
                    <xsl:text>Item net price MUST equal (Gross price - Allowance amount) when gross price is provided.</xsl:text>
                </xsl:element>
            </xsl:element>            
        </xsl:element>  
        
        <xsl:comment>END Pattern from PEPPOL</xsl:comment>
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="*" mode="xrechung-rules" priority="0">        
        <xsl:copy select=".">
            <xsl:apply-templates select="@*" mode="xrechung-rules"/>
            <xsl:apply-templates mode="xrechung-rules"/>
        </xsl:copy> 
    </xsl:template>
    <xsl:template match="@*" mode="xrechung-rules">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="pattern" mode="xrechnung-rules" priority="1">        
        <xsl:variable name="count-number">
            <xsl:variable name="rule-id" select="@id"/>
            <xsl:number level="any" count="pattern[rule/assert/@id=$rules]"/>
        </xsl:variable>
        <xsl:if test="rule/assert/@id=$rules">
            <xsl:element name="active" namespace="{namespace-uri()}">
                <xsl:attribute name="pattern">
                    <xsl:text>peppol-</xsl:text>
                    <xsl:if test="$syntax='UBL'">
                        <xsl:text>ubl</xsl:text>
                    </xsl:if>
                    <xsl:if test="$syntax='CII'">
                        <xsl:text>cii</xsl:text>
                    </xsl:if>
                    <xsl:text>-pattern-</xsl:text>
                    <xsl:value-of select="$count-number"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:if>        
    </xsl:template>
    
    <!-- peppol-rules -->
    <xsl:template match="/*/let" mode="peppol-rules" priority="1">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="/*/xsl:stylesheet/xsl:function" mode="peppol-rules" priority="1">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="/*/let[@name='documentCurrencyCode']" mode="peppol-rules" priority="2">        
        <xsl:copy-of select="."/>
        <xsl:element name="let" namespace="{namespace-uri()}">
            <xsl:attribute name="name"><xsl:text>slackValue</xsl:text></xsl:attribute>
            <xsl:attribute name="value"><xsl:text>if($documentCurrencyCode = 'HUF') then 0.5 else 0.02</xsl:text></xsl:attribute>
        </xsl:element>        
    </xsl:template>
    <xsl:template match="assert" mode="peppol-rules" priority="1">
        <!-- exclude R120 in CII-->
        <xsl:if test="@id=$rules and ((not(@id='PEPPOL-EN16931-R120') and $syntax='CII') or $syntax='UBL')">           
            <xsl:copy select=".">
                <xsl:attribute name="id">
                    <xsl:variable name="rule-id" select="@id"/>
                    <xsl:value-of select="@id"/>                                       
                    <xsl:if test="count(../../rule/assert/@id[. = $rule-id]) &gt; 1">
                        <xsl:text>-</xsl:text>
                        <xsl:value-of><xsl:number level="any" count="assert[@id = $rule-id]"/></xsl:value-of>
                    </xsl:if>
                </xsl:attribute>                  
                <xsl:apply-templates select="@*[not(name()='id')]" mode="peppol-rules"/>
                <!--<xsl:if test="$syntax='CII'">
                    <xsl:attribute name="flag">warning</xsl:attribute>
                </xsl:if>-->
                <xsl:choose>
                    <!-- Replace some texts in CII -->
                    <xsl:when test="@id='PEPPOL-EN16931-R053' and $syntax='CII'">
                        <!-- modify test -->
                        <xsl:attribute name="test">count(ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $documentCurrencyCode]) &lt;=1</xsl:attribute>
                        <xsl:text>No more than one tax total amount must be provided where currency id equals document currency code.</xsl:text>
                    </xsl:when>
                    <xsl:when test="@id='PEPPOL-EN16931-R054' and $syntax='CII'">
                        <xsl:text>Only one tax total amount must be provided where currency id equals tax currency code, if tax currency code (BT-6) is provided.</xsl:text>
                    </xsl:when>
                    <xsl:when test="@id='PEPPOL-EN16931-R101' and $syntax='CII'">
                        <xsl:text>Element Additional referenced document can only be used for Invoice line object.</xsl:text>
                    </xsl:when>
                    <!-- modify R055 in CII to allow for optional BT-110 -->
                    <xsl:when test="@id='PEPPOL-EN16931-R055' and $syntax='CII'">
                        <xsl:attribute name="test">not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode and ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $documentCurrencyCode]) or (ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $taxCurrencyCode] &lt; 0 and ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $documentCurrencyCode] &lt; 0) or (ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $taxCurrencyCode] &gt;= 0 and ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $documentCurrencyCode] &gt;= 0)</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@id='PEPPOL-EN16931-R040' and $syntax='UBL'">
                        <xsl:attribute name="test">not(cbc:MultiplierFactorNumeric and cbc:BaseAmount) or u:slack(if (cbc:Amount) then cbc:Amount else 0, (xs:decimal(cbc:BaseAmount) * xs:decimal(cbc:MultiplierFactorNumeric)) div 100, $slackValue)</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@id='PEPPOL-EN16931-R120' and $syntax='UBL'">
                        <xsl:attribute name="test">u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, $slackValue)</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@id='PEPPOL-EN16931-R040' and $syntax='CII'">
                        <xsl:attribute name="test">not(ram:CalculationPercent and ram:BasisAmount) or u:slack(if (ram:ActualAmount) then ram:ActualAmount else 0, (xs:decimal(ram:BasisAmount) * xs:decimal(ram:CalculationPercent)) div 100, $slackValue)</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates mode="peppol-rules"/>
                    </xsl:otherwise>
                </xsl:choose>                                
            </xsl:copy> 
        </xsl:if>
    </xsl:template>
    <xsl:template match="rule" mode="peppol-rules" priority="1">        
        <xsl:if test="assert/@id=$rules">            
            <xsl:copy select=".">                
                <xsl:apply-templates select="@*" mode="peppol-rules"/>                
                <xsl:apply-templates mode="peppol-rules"/>                
            </xsl:copy>    
        </xsl:if>        
    </xsl:template>    
    <xsl:template match="pattern" mode="peppol-rules" priority="1">       
        <xsl:variable name="count-number">
            <xsl:variable name="rule-id" select="@id"/>
            <xsl:number level="any" count="pattern[rule/assert/@id=$rules]"/>
        </xsl:variable>        
        <xsl:if test="rule/assert/@id=$rules">
            <xsl:copy select=".">
                <xsl:attribute name="id">
                    <xsl:text>peppol-</xsl:text>
                    <xsl:if test="$syntax='UBL'">
                        <xsl:text>ubl</xsl:text>
                    </xsl:if>
                    <xsl:if test="$syntax='CII'">
                        <xsl:text>cii</xsl:text>
                    </xsl:if>
                    <xsl:text>-pattern-</xsl:text>
                    <xsl:value-of select="$count-number"/>
                </xsl:attribute>               
                <xsl:apply-templates select="@*" mode="peppol-rules"/>
                <xsl:apply-templates mode="peppol-rules"/>
            </xsl:copy>    
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*" mode="peppol-rules" priority="0">        
        <xsl:copy select=".">
            <xsl:apply-templates select="@*" mode="peppol-rules"/>
            <xsl:apply-templates mode="peppol-rules"/>
        </xsl:copy> 
    </xsl:template>
    <xsl:template match="@*" mode="peppol-rules">
        <xsl:copy-of select="."/>
    </xsl:template>
   
</xsl:stylesheet>