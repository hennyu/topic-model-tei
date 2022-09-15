# topic-model-tei – Topic Models in TEI

This respository is a supplement to a presentation at the 2022 TEI Conference in Newcastle on "How to Represent Topic Models in Digital Scholarly Editions" by Ulrike Henny-Krahmer and Frederike Neuber (slides and abstract are available on [Zenodo](https://zenodo.org/record/7043204)).

The repository provides:

* **tei-examples** \| example data from the digital edition [_Correspondence of ‘Jean Paul’s surroundings’_ ](zenodo.org/record/6322839)
* **mallet-output** \| results of applying topic modeling to the Jean Paul corpus by using [Mallet](https://mallet.cs.umass.edu/diagnostics.php)
  * topic_state_reduced.csv
  * topics-in-texts_60tp-5000it-100in.csv
  * topics-with-words_60tp-5000it-100in.csv
  * word-weights-reduced.csv 
* **scripts** \| code for transforming Mallet results to XML/TEI
  * topics-with-words-to-taxonomy.xsl \| creates a tei:taxonomy with topics and their most probable words
  * topics-in-texts-to-keywords.xsl \| records the probablity of topics a document in tei:keywords
  * topic-state-to-text.xsl \| embedds references to topics on word level in the document text by using tei:w \[this is work-in-progress\]
  * text-to-html.xsl \| transforms XML with embedded topic references to HTML 

# Content

**html-examples**

* topic-words-in-text.html | example HTML output, in which topic words are highlighted directly in the edition text.

**mallet-output**

* topic_state_60tp-5000it-100in | reduce
* topic_state_reduced.csv
* topics-in-texts_60tp-5000it-100in.csv
* topics-with-words_60tp-5000it-100in.csv
* word-weights-reduced.csv 

**scripts**

* topics-with-words-to-taxonomy.xsl | creates a tei:taxonomy with topics and their most probable words
* topics-in-texts-to-keywords.xsl | records the probablity of topics a document in tei:keywords
* topic-state-to-text.xsl | embedds references to topics on word level in the document text by using tei:w \[this is work-in-progress\]
* text-to-html.xsl | creates HTML example output of topic references in the document text

* reduce-word-weights-file.py | reduces Mallett word-weights

**tei-examples**

* tbd