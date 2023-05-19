<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg" xmlns:exsl="http://exslt.org/common">
    <xsl:output method="xml" indent="yes" standalone="no"
      doctype-public="-//W3C//DTD SVG 1.1//EN"
      media-type="image/svg"/>

    <xsl:variable name = "maxDepth" as="xsd:integer">
        <xsl:for-each select = "//node">
            <xsl:sort select = "@profondeur" data-type = "number" order = "descending"/>
            <xsl:if test = "position() = 1">
                <xsl:value-of select = "@profondeur"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name = "maxLargeur" as="xsd:integer">
        <xsl:for-each select = "//node">
            <xsl:sort select = "@largeur" data-type = "number" order = "descending"/>
            <xsl:if test = "position() = 1">
                <xsl:value-of select = "@largeur"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="sizeDimension" as="xsd:integer">
        <xsl:value-of>500</xsl:value-of>
    </xsl:variable>

    <xsl:variable name="ecartLarg" as="xsd:float">
        <xsl:value-of select="$sizeDimension  div $maxLargeur"/>
    </xsl:variable>

    <xsl:variable name="ecartProf" as="xsd:float">
        <xsl:value-of select="$sizeDimension div $maxDepth"/>
    </xsl:variable>

    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" id="svg2" version="1.0" x="0.00000000000" y="0.00000000000" >
            <xsl:apply-templates select="//node"/>
        </svg>
    </xsl:template>

    <xsl:template match="node[node]">
        <line x1="{./@largeur * $ecartLarg}" y1="{./@profondeur * $ecartProf}" x2="{./@largeur * $ecartLarg}" y2="{(./@profondeur * $ecartProf) + $ecartProf}" style="stroke-width:2;stroke:black;"/>
        <line x1="{./*[1]/@largeur * $ecartLarg}" y1="{./*[1]/@profondeur * $ecartProf}" x2="{./*[last()]/@largeur * $ecartLarg}" y2="{./*[last()]/@profondeur * $ecartProf}" style="stroke-width:2;stroke:black;"/>
    </xsl:template>

    <xsl:template match="node">

        <line x1="{@largeur * $ecartLarg}" 
        y1="{@profondeur * $ecartProf}" 
        x2="{@largeur * $ecartLarg}" 
        y2="{(number(@profondeur) + 1) * $ecartProf}"
        style="stroke:black;stroke-width:2;"/>

        <xsl:if test="number((@profondeur +1)*$ecartProf) lt 1000">

        <line x1="{@largeur * $ecartLarg}" 
        y1="{(@profondeur + 1) * $ecartProf}" 
        x2="{@largeur * $ecartLarg}" 
        y2="{1000}" 
        style="stroke:red;stroke-width:2;"
        stroke-dasharray="5,5"/>

        </xsl:if>
        
    </xsl:template>



</xsl:transform>

    