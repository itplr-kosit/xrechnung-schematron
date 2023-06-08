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
    <!-- List of rules to be integrated -->    
    <xsl:variable name="rules" as="xs:string *">        
        <xsl:for-each select="document('rule-list.xml')/*/r:rule">
            <xsl:comment>
                <xsl:value-of select="."/>
            </xsl:comment>
            <xsl:value-of select="."/>
        </xsl:for-each>        
    </xsl:variable>
    
    <xsl:template match="/">    
        <xsl:apply-templates mode="xrechung-rules"/>
    </xsl:template>
    
    <!-- Adds global lets from PEPPOL --> 
    <xsl:template match="/*/ns[last()]" mode="xrechung-rules" priority="1">        
        <xsl:copy-of select="."/>    
        <xsl:comment>BEGIN Parameters from PEPPOL</xsl:comment>
        <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/let" mode="peppol-rules"/>
        <xsl:comment>END Parameters from PEPPOL</xsl:comment>          
    </xsl:template>
    <xsl:template match="/*/pattern[@id='ubl-pattern']" mode="xrechung-rules" priority="1">        
        <xsl:comment>BEGIN Pattern from PEPPOL</xsl:comment>
        <xsl:apply-templates select="document('../../build/bis/PEPPOL-EN16931-UBL.sch')/*/pattern" mode="peppol-rules"/>
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
    
    <!-- peppol-rules -->
    <xsl:template match="/*/let" mode="peppol-rules" priority="1">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="assert" mode="peppol-rules" priority="1">        
        <xsl:if test="@id=$rules">
            <xsl:copy-of select="."/> 
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
        <xsl:if test="rule/assert/@id=$rules">
            <xsl:copy select=".">
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