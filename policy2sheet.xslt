<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias">
<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>

<xsl:param name="TPL" select="document('template.xslt.in')" />
<xsl:template match="/">

    <axsl:template match="node()|@*">
      <axsl:copy>
        <axsl:apply-templates select="node()|@*"/>
      </axsl:copy>
    </axsl:template>

    <axsl:template>
<!--match='domain[policies/guest/@os="rhel-7"]' id="PP">-->
<xsl:attribute name="match">
<xsl:value-of select="TPL/"/>
</xsl:attribute>
      <axsl:copy>
      <axsl:apply-templates select="node()|@*" />
      <!-- Things to be added -->
      </axsl:copy>
    </axsl:template>
</xsl:template>
</xsl:stylesheet>
