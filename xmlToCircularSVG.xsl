<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg" xmlns:exsl="http://exslt.org/common" xmlns:math="http://www.w3.org/2005/xpath-functions/math">
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

    <xsl:variable name="ecartAngle" as="xsd:float">
        <xsl:value-of select="(360  div $maxLargeur)*math:pi() div 180"/>
    </xsl:variable>

    <xsl:variable name="longueurTrait" as="xsd:float">
        <xsl:value-of select="250 div $maxDepth"/>
    </xsl:variable>

    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" id="svg2" version="1.0" x="0.00000000000" y="0.00000000000" >
            <xsl:apply-templates select="//node"/>
        </svg>
    </xsl:template>

    <xsl:template match="node[node]">
        <line
        x1="{math:cos( (@largeur - 1) * $ecartAngle)* ($longueurTrait * ./@profondeur) + 500}" 
        y1="{math:sin( (./@largeur - 1) * $ecartAngle +math:pi())* ($longueurTrait * ./@profondeur)  + 500}" 
        x2="{math:cos( (./@largeur - 1) * $ecartAngle) * ($longueurTrait * (./@profondeur + 1))  + 500}" 
        y2="{math:sin( (./@largeur - 1) * $ecartAngle +math:pi()) * ($longueurTrait * (./@profondeur + 1))  + 500}" 
        style="stroke-width:10;stroke:yellow;"/>

        <!--<path d="M {500 + math:cos(./node[1]/@largeur * $ecartAngle))* $longueurTrait * (./@profondeur + 1)}
                   {500 + math:sin(./node[1]/@largeur * $ecartAngle +math:pi())* $longueurTrait * (./@profondeur + 1)} 
                 A {(./@profondeur + 1) * $longueurTrait} {(./@profondeur + 1) * $longueurTrait} 0 1 0
                    {500 + math:cos(./node[last()]/@largeur * $ecartAngle) * $longueurTrait * (./@profondeur + 1)} 
                    {500 + math:sin(./node[last()]/@largeur * $ecartAngle +math:pi()) * $longueurTrait * (./@profondeur + 1)}"/>
    -->
    </xsl:template>

    <xsl:template match="node">        
         <line
         x1="{math:cos((./@largeur - 1) * $ecartAngle) * ($longueurTrait * ./@profondeur) + 500}" 
         y1="{math:sin((./@largeur - 1) * $ecartAngle +math:pi()) * ($longueurTrait * ./@profondeur) + 500}" 
         x2="{math:cos((./@largeur - 1) * $ecartAngle) * ($longueurTrait * (./@profondeur + 1)) + 500}" 
         y2="{math:sin((./@largeur - 1) * $ecartAngle +math:pi()) * ($longueurTrait * (./@profondeur + 1)) + 500}" 
         style="stroke-width:10;stroke:blue;"/>

        <xsl:if test="$maxDepth gt number(@profondeur)">

        <line
         x1="{math:cos((./@largeur - 1) * $ecartAngle) * ($longueurTrait *  (./@profondeur + 1)) + 500}" 
         y1="{math:sin((./@largeur - 1) * $ecartAngle +math:pi()) * ($longueurTrait * (./@profondeur + 1)) + 500}" 
         x2="{math:cos((./@largeur - 1) * $ecartAngle) * ($longueurTrait * ($maxDepth+1)) + 500}" 
         y2="{math:sin((./@largeur - 1) * $ecartAngle +math:pi()) * ($longueurTrait * ($maxDepth+1)) + 500}" 
         style="stroke-width:5;stroke:red;"/>

        </xsl:if>
        
    </xsl:template>



</xsl:transform>

    