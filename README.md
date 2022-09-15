# topic-model-tei – Topic Models in TEI

This respository is a supplement to a presentation held at the 2022 TEI Conference in Newcastle on "How to Represent Topic Models in Digital Scholarly Editions" by Ulrike Henny-Krahmer and Frederike Neuber. Slides and abstract of the talk are available on [Zenodo](https://zenodo.org/record/7043204). The repository provides data and code that illustrates how a topic model could be integrated into XML/TEI documents of a digital scholarly edition.

# Content

The repository provides data

* **tei-examples** \| example data from the digital edition [_Correspondence of ‘Jean Paul’s surroundings’_ ](zenodo.org/record/6322839)
* **mallet-output** \| results of applying topic modeling to the Jean Paul corpus by using [Mallet](https://mallet.cs.umass.edu/diagnostics.php)
* **scripts** \| code for transforming Mallet results to XML/TEI
  * topics-with-words-to-taxonomy.xsl \| creates a tei:taxonomy with topics and their most probable words
  * topics-in-texts-to-keywords.xsl \| records the probablity of the occurence topics in a document in tei:keywords
  * topic-state-to-text.xsl \| embedds references to topics on word level in the document text by using tei:w \[this is work-in-progress\]
  * text-to-html.xsl \| transforms XML with embedded topic references to HTML 
* **html-examples** \| examplary HTML output, in which topic words are highlighted directly in the edition text

# License

# Citation