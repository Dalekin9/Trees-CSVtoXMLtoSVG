<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output indent="yes"/>

    <xsl:template match="node[node]" mode="xml2layout">

        <xsl:variable name="subTree">

            <xsl:apply-templates select="node" mode="xml2layout"/>

        </xsl:variable>

        <!-- Add layout attributes to the existing node -->

        <node width="{sum(exsl:node-set($subTree)/node/@width)}">

            <!-- Copy original attributes and content -->

            <xsl:copy-of select="@*"/>

            <xsl:copy-of select="$subTree"/>

        </node>

    </xsl:template>

    <!-- Add layout attributes to leaf nodes -->

    <xsl:template match="node" mode="xml2layout">

        <node width="1">

            <xsl:copy-of select="@*"/>

        </node>

    </xsl:template>

</xsl:transform>