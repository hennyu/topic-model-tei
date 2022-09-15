# Topic Models in TEI

This respository is a supplement to a presentation held at the 2022 TEI Conference in Newcastle on "How to Represent Topic Models in Digital Scholarly Editions" by Ulrike Henny-Krahmer and Frederike Neuber. Slides and abstract of the talk are available on [Zenodo](https://zenodo.org/record/7043204). The repository provides data and code that illustrate how topic models could be integrated into digital scholarly editions by transforming the results of a modeling with [Mallet](https://mallet.cs.umass.edu/diagnostics.php) to XML/TEI. 

# Content

* **tei-examples:** example data from the digital edition [_Correspondence of ‘Jean Paul’s surroundings’_ ](zenodo.org/record/6322839)
* **mallet-output:** results of applying topic modeling to the Jean Paul corpus by using Mallet.
* **scripts:** code for transforming Mallet results to XML/TEI
  * topics-with-words-to-taxonomy.xsl: creates a tei:taxonomy with topics and their most probable words
  * topics-in-texts-to-keywords.xsl: records the probablity of the occurence topics in a document in tei:keywords
  * topic-state-to-text.xsl: embedds references to topics on word level in the document text by using tei:w \[this is work-in-progress\]
  * text-to-html.xsl: transforms XML with embedded topic references to HTML 
* **html-examples:** examplary HTML output, in which topic words are highlighted directly in the edition text

# License

The content of this repository is available under [CC BY-SA 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/deed.de).

# Citation

For reusing any content of the repository, please cite us as follows: 

Henny-Krahmer, Ulrike and Frederike Neuber. 2022. “Topic Models in TEI.” GitHub.com. https://github.com/hennyu/topic-model-tei.