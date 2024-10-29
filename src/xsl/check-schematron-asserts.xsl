<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="text" />

  <xsl:template match="*:assert">
    <xsl:choose>
      <xsl:when test="text()">
        <xsl:value-of>true</xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of>false</xsl:value-of>
        <xsl:message terminate="yes">The assertion with id="<xsl:value-of
            select="@id" />" has no error message text</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
