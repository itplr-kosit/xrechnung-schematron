<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="2.0">
  <xsl:output method="text" />
  <xsl:template match="/*">
    <xsl:choose>
      <xsl:when test="count(/*/*[local-name()='pattern']/*[local-name()='rule']/*[local-name()='assert'][not(text())]) = 0">
        <xsl:value-of>true</xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of>false</xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
