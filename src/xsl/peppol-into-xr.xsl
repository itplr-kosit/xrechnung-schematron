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
                <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-CII.sch')/*/pattern" mode="xrechnung-rules"/>
            </xsl:if>              
        </xsl:copy> 
    </xsl:template>
    
    <!-- Adds global lets from PEPPOL --> 
    <xsl:template match="/*/ns[last()]" mode="xrechung-rules" priority="1">        
        <xsl:copy-of select="."/>    
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
            <xsl:number count="."/>
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
    <xsl:template match="assert" mode="peppol-rules" priority="1">
        <xsl:if test="@id=$rules">           
            <xsl:copy select=".">
                <xsl:attribute name="id">
                    <xsl:variable name="rule-id" select="@id"/>
                    <xsl:value-of select="@id"/>                                       
                    <xsl:if test="count(../../rule/assert/@id[. = $rule-id]) &gt; 1">
                        <xsl:text>-</xsl:text>
                        <xsl:value-of><xsl:number count="."/></xsl:value-of>
                    </xsl:if>
                </xsl:attribute>
                <xsl:apply-templates select="@*[not(name()='id')]" mode="peppol-rules"/>
                <xsl:apply-templates mode="peppol-rules"/>
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
            <xsl:number count="."/>
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