#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

class AudioTranscription
  class Error < StandardError; end

  def initialize(file_path, model)
    @file_path = file_path
    @model = model
  end

  def send_request
    uri = URI.parse('http://tinybot:8080/v1/audio/transcriptions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 3600

    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'multipart/form-data'

    form_data = [['file', File.new(@file_path)], ['model', @model]]
    request.set_form form_data, 'multipart/form-data'

    response = http.request(request)

    # Handle the response as needed
    JSON.parse(response.body)
  end
end

# Example usage
begin
  transcription_request = AudioTranscription.new(ARGV[0], 'whisper-1')
  response_raw = transcription_request.send_request
rescue AudioTranscription::Error => e
  puts "An error occurred: #{e.message}"
end

# response_raw["segments"].each do |segment|
#   p segment["text"]
#   puts '\n'
# end
p response_raw

p response_raw["text"]

#puts x.dig("segments", 0, "text")

# @transcript[:segments].each do |segment|
#   puts "#{segment[:text]}"
# end
