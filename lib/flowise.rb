#!/usr/bin/env ruby
# frozen_string_literal: true

require 'net/http'
require 'json'

API_URL = "https://api-inference.huggingface.co/models/meta-llama/Llama-2-70b-chat-hf"
HEADERS = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{ENV["HUGGINGFACE_API_KEY"]}"
}

curl http://ninjabot.syncopated.net:3002/api/v1/prediction/ecf5c824-2b18-43ab-8eb9-2a8a750d4b29 \
     -X POST \
     -d '{"question": "Explain the `TextEmbeddings` class", "overrideConfig": {"collectionName": "monadic", "chromaURL": "http://ninjabot.syncopated.net:8000" }}' \
     -H "Content-Type: application/json"


curl http://ninjabot.syncopated.net:3002/api/v1/prediction/31569551-f932-4291-a2c5-16d095387f05 \
     -X POST \
     -d '{"question": "Provide high-level overview of repository", "overrideConfig": {"repoLink": "https://github.com/andreibondarev/langchainrb", "branch": "main", "recursive": true }}' \
     -H "Content-Type: application/json"
