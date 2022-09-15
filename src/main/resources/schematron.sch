<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <sch:ns prefix="fn" uri="tag:dmaus@dmaus.name,2022:Schematron-Schematron"/>
  <sch:ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
  <sch:ns prefix="xpath20" uri="tag:dmaus@dmaus.name,2022:Schematron-Schematron:XPath20"/>
  <sch:ns prefix="xpath31" uri="tag:dmaus@dmaus.name,2022:Schematron-Schematron:XPath31"/>
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>

  <sch:let name="queryBinding" value="'xslt2'"/>

  <xsl:include href="xpath20.xslt"/>
  <xsl:include href="xpath31.xslt"/>

  <xsl:function name="fn:validate-xpath" as="item()*">
    <xsl:param name="exprAttr" as="attribute()"/>
    <xsl:param name="queryBinding" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="$queryBinding eq 'xslt2'">
        <xsl:sequence select="xpath20:parse-XPath($exprAttr)"/>
      </xsl:when>
      <xsl:when test="$queryBinding eq 'xslt3'">
        <xsl:sequence select="xpath31:parse-XPath($exprAttr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">Unsupported query language binding: <xsl:value-of select="$queryBinding"/></xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <sch:pattern>
    <sch:rule context="sch:rule/@context | sch:assert/@test | sch:report/@test | sch:value-of/@select | sch:name/@path | sch:pattern/@documents | xsl:copy-of/@select">
      <sch:let name="queryBinding" value="lower-case((ancestor::sch:schema/@queryBinding, $queryBinding, 'xslt')[1])"/>
      <sch:let name="result" value="fn:validate-xpath(., $queryBinding)/self::ERROR"/>
      <sch:report test="$result/self::ERROR">
        <sch:value-of select="$result/self::ERROR"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>

</sch:schema>
