<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!--
        to do:
        convert information from topic state file (about which words in a text are associated with which topic)
        into embedded markup in the text body of the text's TEI document
        
        (problems caused by preprocessing steps need to be solved)
        
        
        @author: Ulrike Henny-Krahmer
        
    -->
    
    <xsl:variable name="document-path">file:/home/ulrike/Git/jp-topics/data/letters-context/ub0121.txt</xsl:variable>
    <xsl:variable name="topic-state-file">../mallet-output/topic_state_reduced.csv</xsl:variable>
    <xsl:variable name="input-tei">../tei-examples/ub0121_1825-12-22_CvStein_CRichter.xml</xsl:variable>
    
    <xsl:template match="/">
        <xsl:analyze-string select="unparsed-text($topic-state-file)" regex="^\d+\t([^\t]+)\t(.*)[\n|\r]" flags="m">
            <xsl:matching-substring>
                <xsl:if test="regex-group(1)=$document-path">
                    <!-- ... -->
                </xsl:if>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    
</xsl:stylesheet>