# SyncopatedLLM

> In the document processing pipeline, various Rubygems play essential roles. Firstly, `pragmatic_tokenizer` is utilized for tokenization and text sanitation, ensuring the cleanliness of the text. Then, `ruby-spacy` comes into play, providing part-of-speech tagging, dependency parsing, and named entity recognition (NER). For topic modeling, we employ `tomoto`, initially training the LDA model on an array of documents to establish topics. Once this training is complete, future documents are then modeled based on this established structure. Additionally, we leverage `ruby-wordnet` to access the WordNet lexical database, enhancing semantic analysis. The process is orchestrated using `langchain` to access LLM APIs efficiently. The metadata of each document is cached using `ohm`. For efficient handling of JSONL files, `jsonl` is employed. Lastly, the resulting vector data is stored in a vector database, `chromadb`, for further analysis and retrieval.


> Each entry in the array undergoes a multi-step processing. First, the text within each entry is segmented into chunks. Each chunk then undergoes tokenization and sanitization processes. Next, we apply topic modeling to these sanitized chunks to extract topic information. This metadata is appended to a JSON entry for the document, which includes a title, an ID, and an array of chunks. Each chunk is associated with it's parent document and topics. 

```bash
require 'ruby-spacy'
python3 -m spacy download en_core_web_sm && \
python3 -m spacy download en_core_web_lg
```