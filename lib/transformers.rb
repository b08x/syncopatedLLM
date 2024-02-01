curl https://api-inference.huggingface.co/models/sentence-transformers/paraphrase-MiniLM-L3-v2 \
        -X POST \
        -d '{"inputs": { "source_sentence": "That is a happy person", "sentences": [ "That is a happy dog", "That is a very happy person", "Today is a sunny day" ] }}' \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer $HUGGINGFACE_API_KEY
