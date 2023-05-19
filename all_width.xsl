<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name = "maxDepth" as="xsd:integer">
        <xsl:for-each select = "tree//node">
            <xsl:sort select = "@profondeur" data-type = "number" order = "descending"/>
            <xsl:if test = "position() = 1">
                <xsl:value-of select = "@profondeur"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">

        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        
        <xsl:apply-templates select="tree//node/@largeur">
            <xsl:with-param name="profondeur" select="$maxDepth - 1"/>
        </xsl:apply-templates>
        
    </xsl:template>

     <xsl:template name="width_line" match="@largeur[parent::node]">
        <xsl:param name="profondeur" select="$maxDepth - 1" as="xsd:integer"/>

        <xsl:if test="$profondeur ge 0">
            <xsl:if test="number(.[parent::*[@profondeur]]) eq $profondeur">
                <xsl:attribute name="largeur">
                    <xsl:value-of select="self[1][@largeur]"/>
                </xsl:attribute>
            </xsl:if>
            
            <xsl:copy>CA
            </xsl:copy>
            <xsl:call-template name="width_line">
                <xsl:with-param name="profondeur" select="$profondeur - 1"/>
            </xsl:call-template>
        </xsl:if>


    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:transform>