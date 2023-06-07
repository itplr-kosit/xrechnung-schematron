<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://purl.oclc.org/dsdl/schematron"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:ubl-creditnote="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:ubl-invoice="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2">
    <xsl:output indent="true"/>
    <xsl:namespace-alias stylesheet-prefix="ubl-creditnote" result-prefix="cn"/>
    <xsl:namespace-alias stylesheet-prefix="ubl-invoice" result-prefix="ubl"/>
    <!-- List of rules to be integrated -->
    <xsl:variable name="rules" as="xs:string *">        
        <xsl:value-of select="'PEPPOL-EN16931-R001'"/>        
        <xsl:value-of select="'PEPPOL-EN16931-R002'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R003'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R004'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R005'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R007'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R010'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R053'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R054'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R055'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R056'"/>
        <xsl:value-of select="'PEPPOL-EN16931-R080'"/>
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
        <xsl:choose>
            <xsl:when test="name(.) = 'context'">
                <xsl:attribute name="context">
                    <xsl:value-of select="replace(replace(., 'ubl-creditnote:', 'cn:'), 'ubl-invoice:', 'ubl:')"/>
                </xsl:attribute>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>        
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
   
</xsl:stylesheet>