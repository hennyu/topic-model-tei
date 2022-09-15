<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">

    <xsl:output method="xml" indent="yes"/> 
    
    <!--
        
        convert topics from topics-with-words file to an index file with taxonomy section,
        adds probability values from word-weights file to single words. 
               
        
        @author: Frederike Neuber
        
    -->

    <xsl:variable name="topics-with-words-file">../mallet-output/topics-with-words_60tp-5000it-100in.csv</xsl:variable>
    <xsl:variable name="word-weights-file">../mallet-output/word-weights-reduced.csv</xsl:variable>

    <xsl:template match="/">
        <xsl:result-document href="{'../tei-examples/tm-taxonomy.xml'}">
            
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>60 Topics with 50 most probable words and their probability values</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <bibl xml:id="corpus">Neuber, Frederike and Ulrike Henny-Krahmer. 2022. “Topic
                            modeling the correspondence of Jean Paul’s surroundings” (v.1.0).
                            Zenodo. https://doi.org/#####, GitHub: https://github.com/FrederikeNeuber/jeanpaul-topics.</bibl>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <classDecl>
                        <taxonomy xml:id="tm0001" corresp="#corpus">
                            <desc>Topic model of the correspondence of the surroundings of Jean Paul
                                (1156 letters), based on the edited texts with normalized ortography
                                and prepared with Mallet (mallet-2.0.8RC3, LDA) with the following 
                                parameters: 60 topics, 5000 iterations, hyperparameter optimization 
                                interval of 100, 50 top words per topic.</desc>
                            
                            <!-- get topics with 50 most probable words -->
                            <xsl:analyze-string select="unparsed-text($topics-with-words-file)" regex="^(\d+)\t([^\t].*)\t(.*)[\n|\r]" flags="m">
                                <xsl:matching-substring>
                                    <xsl:variable name="topic-number" select="regex-group(1)"/>
                                          <xsl:for-each select="regex-group(1)">
                                                <category xml:id="t{.}">
                                                    <catDesc n="label"><xsl:comment>manual editing</xsl:comment></catDesc>
                                                    <catDesc n="alpha"><xsl:value-of select="replace(regex-group(2), ',', '.')"/></catDesc>
                                                    <catDesc n="topwords">
                                                        <xsl:for-each select="tokenize(regex-group(3),'\s')">                                                            
                                                            <xsl:sort select="position()"/>
                                                            <xsl:variable name="word" select="."/>
                                                            <xsl:if test=". != ''">
                                                                <gloss>
                                                                    <xsl:attribute name="n">
                                                                        
                                                                        <!-- get word weight for each gloss -->
                                                                        <xsl:analyze-string select="unparsed-text($word-weights-file)" regex="^(\d+)\t([^\t].*)\t(.*)[\n|\r]" flags="m">
                                                                            <xsl:matching-substring>                                                                                
                                                                                <xsl:if test="regex-group(1) = $topic-number and regex-group(2) = $word">
                                                                                    <xsl:value-of select="regex-group(3)"/>
                                                                                </xsl:if>
                                                                            </xsl:matching-substring>
                                                                        </xsl:analyze-string>                                                                        
                                                                       
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="."/>
                                                                </gloss>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </catDesc>
                                                </category>    
                                            </xsl:for-each>
                                </xsl:matching-substring>
                            </xsl:analyze-string>                          
                        </taxonomy>
                    </classDecl>
                </encodingDesc>
            </teiHeader>
            <text>
                <body>
                   <p/>
                </body>
            </text>
        </TEI>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>
