<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 
        Script to convert individual letter example with annotated topic words from TEI to HTML
        
        @author: Ulrike Henny-Krahmer 
    -->
    
    <xsl:output method="html"/>
    
    <xsl:variable name="taxomony-doc">../tei-examples/tm-taxonomy.xml</xsl:variable>
    
    <xsl:variable name="colors">
        <list xmlns="http://www.tei-c.org/ns/1.0">
            <item>rgba(51, 102, 204, 1)</item>
            <item>rgba(220, 57, 18, 1)</item>
            <item>rgba(255, 153, 0, 1)</item>
            <item>rgba(16, 150, 24, 1)</item>
            <item>rgba(153, 0, 153, 1)</item>
            <!--<item>#3366cc</item>
            <item>#dc3912</item>
            <item>#ff9900</item>
            <item>#109618</item>
            <item>#990099</item>
            <item>#0099c6</item>
            <item>#dd4477</item>
            <item>#66aa00</item>
            <item>#b82e2e</item>
            <item>#316395</item>
            <item>#994499</item>
            <item>#22aa99</item>
            <item>#aaaa11</item>
            <item>#6633cc</item>
            <item>#e67300</item>
            <item>#8b0707</item>
            <item>#651067</item>
            <item>#329262</item>
            <item>#5574a6</item>
            <item>#3b3eac</item>
            <item>#b77322</item>
            <item>#16d620</item>
            <item>#b91383</item>
            <item>#f4359e</item>
            <item>#9c5935</item>
            <item>#a9c413</item>
            <item>#2a778d</item>
            <item>#668d1c</item>
            <item>#bea413</item>
            <item>#0c5922</item>
            <item>#743411</item>-->
        </list>
    </xsl:variable>
    
    <xsl:variable name="topics">
        <list xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each-group select="//w" group-by="@ana">
                <xsl:variable name="topic-pointer" select="concat('#t',substring-after(current-grouping-key(),'tm:'))"/>
                <item pos="{position()}" n="{//keywords/term[@ana=$topic-pointer]/@n}"><xsl:value-of select="$topic-pointer"/></item>
            </xsl:for-each-group>
        </list>
    </xsl:variable>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Jean Paul letter example</title>
            </head>
            <body>
                <div>
                    <xsl:for-each select="$topics//item">
                        <xsl:sort select="@n" order="descending" data-type="number"/>
                        <xsl:variable name="topic-pos" select="@pos"/>
                        <xsl:variable name="topic-num" select="substring-after(.,'#t')"/>
                        <xsl:variable name="topic-prob" select="number(@n)"/>
                        <p style="font-weight: bold;">
                            <span style="color: white; display: inline-block; padding: 3px; width: {$topic-prob * 1000}px; height: 20px; background-color: {$colors//item[position()=$topic-pos]};"><xsl:value-of select="round($topic-prob  * 1000) div 1000"/></span>
                            topic <xsl:value-of select="$topic-num"/>: <xsl:value-of select="doc($taxomony-doc)//category[@xml:id=concat('t',$topic-num)]/catDesc[@n='topwords']/string-join(gloss[position()=1 to 3], '-')"/>
                        </p>
                    </xsl:for-each>
                </div>
                <div>
                    <xsl:apply-templates select=".//body"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="pb">
        <p>[<xsl:value-of select="@n"/>]</p>
    </xsl:template>
    
    <xsl:template match="opener">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="dateline">
        <p style="text-align: right;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="hi[@rendition='#sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <xsl:template match="hi[@rendition='#uu']">
        <span style="text-decoration: underline;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="hi[@rendition='#c']">
        <p style="text-align: center;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="hi[@rendition='#right']">
        <p style="text-align: right;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="space">
        [ ]
    </xsl:template>
    
    <xsl:template match="note">
        [<xsl:apply-templates/>]
    </xsl:template>
    
    <xsl:template match="closer">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="w">
        <xsl:variable name="topic" select="concat('#t',substring-after(@ana,'tm:'))"/>
        <xsl:variable name="topic-num" select="substring-after(@ana,'tm:')"/>
        <xsl:variable name="topic-pos" select="$topics//item[.=$topic]/@pos"/>
        <xsl:variable name="wnorm" select="@norm"/>
        <xsl:variable name="topiccolor" select="$colors//item[position()=$topic-pos]"/>
        <xsl:variable name="topword" select="doc($taxomony-doc)//category[@xml:id=concat('t',$topic-num)]/catDesc[@n='topwords']/gloss[.=$wnorm]"/>
        <xsl:variable name="opacity">
            <xsl:choose>
                <xsl:when test="exists($topword) and count($topword/preceding-sibling::gloss) &lt;= 9">1.0</xsl:when>
                <xsl:when test="exists($topword) and count($topword/preceding-sibling::gloss) &lt;= 19">0.9</xsl:when>
                <xsl:when test="exists($topword) and count($topword/preceding-sibling::gloss) &lt;= 29">0.8</xsl:when>
                <xsl:when test="exists($topword) and count($topword/preceding-sibling::gloss) &lt;= 39">0.7</xsl:when>
                <xsl:when test="exists($topword)">0.6</xsl:when>
                <xsl:otherwise>0.5</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="fontcolor">
            <xsl:choose>
                <xsl:when test="$opacity &lt;= number(0.6)">black</xsl:when>
                <xsl:otherwise>white</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <span title="{@norm}" style="display: inline-block; padding: 3px; color: {$fontcolor}; background-color: {replace($topiccolor,'1\)',concat($opacity,')'))};">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    
</xsl:stylesheet>