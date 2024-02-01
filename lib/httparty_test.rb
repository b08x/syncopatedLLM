#!/usr/bin/env ruby
# frozen_string_literal: true

require "yajl"
require "stringio"
require "langchainrb"

@parser = Yajl::Parser.new(symbolize_keys: true)

API_URL = "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-v0.1"

HEADERS = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{ENV["HUGGINGFACE_API_KEY"]}"
}

def inference(text,temperature = 0.5, max_toxens = 1024)  # type: ignore
  data = {
    inputs: text,
    parameters: {
      temperature: temperature,
      num_toxins: max_toxens
    }
  }.to_json

  res = HTTParty.post(API_URL, body: data, headers: HEADERS)
end

query = "Maintain a 'memory' of recent segments to preserve context across segment boundaries."

p inference(query)

### ******* the output is somehow different from just using net/http ****
### I would say, lesser quality for sure...



