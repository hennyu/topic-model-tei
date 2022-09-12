<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <!--
        convert numbers from topics-in-texts to tei keywords section
        for one specific document of the corpus
        (next steps:
            - generalize this script to treat the whole collection
            - integrate resulting keywords-snippets directly into the TEI files of the corpus
            )
        
        
        @author: Ulrike Henny-Krahmer
        
    -->
    
    <xsl:variable name="document-path">file:/home/ulrike/Git/jp-topics/data/letters-context/ub0850.txt</xsl:variable>
    <!-- ub0923.txt -->
    <xsl:variable name="topics-in-texts-file">topics-in-texts_60tp-5000it-100in.csv</xsl:variable>
    
    <xsl:template match="/">
        <xsl:analyze-string select="unparsed-text($topics-in-texts-file)" regex="^\d+\t([^\t]+)\t(.*)[\n|\r]" flags="m">
            <xsl:matching-substring>
                <xsl:if test="regex-group(1)=$document-path">
                    <keywords scheme="tm-taxonomy.xml">
                        <xsl:for-each select="tokenize(regex-group(2),'\t')">
                            <term ana="#t{position() - 1}" n="{.}"/>    
                        </xsl:for-each>
                    </keywords>
                </xsl:if>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
</xsl:stylesheet>