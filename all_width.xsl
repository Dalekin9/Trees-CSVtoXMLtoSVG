<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" xmlns:exsl="http://exslt.org/common">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="node">

        <xsl:variable name="subTree">

            <xsl:apply-templates select="node">

            </xsl:apply-templates>

        </xsl:variable>

        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>

            <xsl:attribute name="largeur">

                <xsl:if test="*">
                    <xsl:value-of select="sum(exsl:node-set($subTree)/node[last()]/@largeur | exsl:node-set($subTree)/node[1]/@largeur) div 2"/>
                </xsl:if>

                <xsl:if test="not(*)">                
                    <xsl:value-of select="@largeur"/>
                </xsl:if>
                
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>

            <xsl:attribute name="profondeur">
                <xsl:value-of select="@profondeur"/>
            </xsl:attribute>

            <xsl:apply-templates select="*"/>


        </xsl:copy>

    </xsl:template>

</xsl:transform>