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
        
        <xsl:call-template name="width_line">
            <xsl:with-param name="profondeur" select="$maxDepth - 1"/>
        </xsl:call-template>
        
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="width_line">
        <xsl:param name="profondeur" as="xsd:integer"/>

        <xsl:if test="number($profondeur) ge 0">
            <xsl:for-each select="tree//node">
                <xsl:if test="number(@profondeur) eq $profondeur">
                    <xsl:attribute name="largeur">
                        <xsl:value-of select="self[parent::*[1][@largeur]]"/>
                    </xsl:attribute>
                    <xsl:copy>cacaca
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:copy>CA
            </xsl:copy>
            <xsl:call-template name="width_line">
                <xsl:with-param name="profondeur" select="$profondeur - 1"/>
            </xsl:call-template>
        </xsl:if>


    </xsl:template>

</xsl:transform>