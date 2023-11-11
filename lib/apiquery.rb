#!/usr/bin/env ruby
# frozen_string_literal: true

require 'net/http'
require 'json'


HEADERS = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{ENV["HUGGINGFACE_API_KEY"]}"
}

#API_URL = "https://api-inference.huggingface.co/models/superb/hubert-large-superb-er"
# API_URL = "https://api-inference.huggingface.co/models/MIT/ast-finetuned-audioset-10-10-0.4593"

# genre classification
API_URL = "https://api-inference.huggingface.co/models/sanchit-gandhi/distilhubert-finetuned-gtzan"

def query(filename)
  data = File.binread(filename)
  uri = URI.parse(API_URL)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/octet-stream'})

  # Add headers from the HEADERS variable
  HEADERS.each { |key, value| request[key] = value }

  request.body = data

  response = http.request(request)

  JSON.parse(response.body)
end

data = query("/mnt/bender/backup/Library/sounds/fx/bbc_radio/ebu-norm/temp.ogg")

p data

# [{"score"=>0.4463595449924469, "label"=>"Music"}, {"score"=>0.11388605087995529, "label"=>"Smash, crash"}, {"score"=>0.05403658375144005, "label"=>"Speech"}, {"score"=>0.04698070138692856, "label"=>"Thump, thud"}, {"score"=>0.02980891801416874, "label"=>"Chink, clink"}]
