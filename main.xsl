<xsl:transform version="3.0" expand-text="yes"
               xmlns:p="tag:dmaus@dmaus.name,2022:Schematron-Schematron:XPath31"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:output indent="yes"/>

  <xsl:include href="src/main/resources/xpath31.xslt"/>

  <xsl:template name="main">
    <xsl:sequence select="p:parse-XPath('normalize-space(@ident)')"/>
  </xsl:template>

</xsl:transform>
