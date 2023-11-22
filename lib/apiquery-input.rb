#!/usr/bin/env ruby
# frozen_string_literal: true

require "net/http"
require "json"
require "langchainrb"
require "openai"
require "chroma-db"

# Instantiate the Chroma client
chroma = Langchain::Vectorsearch::Chroma.new(
  url: ENV["CHROMA_URL"],
  index_name: "documents",
  llm: Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
)

# API_URL = "https://api-inference.huggingface.co/models/meta-llama/Llama-2-70b-chat-hf"
API_URL = "https://api-inference.huggingface.co/models/meta-llama/Llama-2-7b-chat-hf"

HEADERS = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{ENV["HUGGINGFACE_API_KEY"]}"
}

def create_json_object(source_sentence, sentences)
  {
    inputs: {
      source_sentence: source_sentence,
      sentences: sentences
    }
  }.to_json
end

def inference(inputs, temperature = 0.5, max_new_tokens = 1000)
  data = {
    "inputs" => inputs,
    "parameters" => {
      "temperature" => temperature,
      "max_new_tokens" => max_new_tokens
    }
  }

  uri = URI.parse(API_URL)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true # Use HTTPS

  request = Net::HTTP::Post.new(uri.path, HEADERS)
  request.body = data.to_json

  response = http.request(request)
end

query = ARGV[0]

response = inference(query)

p JSON.parse(response.body)

# /apiquery-input.rb "To resolve a conflict with pulseaudio and jack2-dbus"
# {"generated_text"=>"To resolve a conflict with pulseaudio and jack2-dbus, I followed the instructions here:\n\nhttps://askubuntu.com/questions/1070478/pulseaudio-and-jack-issue-with-dbus\n\nI created a systemd service file to start jack2-dbus before pulseaudio.service. Here is the content of the file:\n\n```\n[Unit]\nDescription=Start jack2-dbus before pulseaudio\n\n[Timing]\nBefore=pulseaudio.service\n\n[Service]\nExecStart=/usr/bin/jackdbus\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\n```\n\nI created the file `/etc/systemd/system/jack2-dbus-pulseaudio.service` and enabled it with `sudo systemctl enable jack2-dbus-pulseaudio.service`.\n\nAfter a reboot, the conflict persists. I tried another approach by adding `jackdbus` to the `pulseaudio.service` file, like this:\n\n```\n[Unit]\nDescription=Sound Service\nAfter=network.target pulseaudio.service\n\n[Service]\nUser=pulse\nExecStart=/usr/bin/pulseaudio --start\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\n\nExecStartPre=/usr/bin/jackdbus\n```\n\nNo luck, the conflict still persists. What am I doing wrong or what else can I try?\n\nAnswer: You've tried two different approaches, and neither has worked. Here are a few additional things you can try:\n\n1. Make sure that the `jackdbus` service is actually running before pulseaudio. You can check this by running `systemctl status jack2-dbus-pulseaudio.service"}

# /apiquery-input.rb "There is no sound coming from the speakers. I am running ubuntu with jack2-dbus"
# {"generated_text"=>"There is no sound coming from the speakers. I am running ubuntu with jack2-dbus and pulseaudio, and I have tried disabling pulseaudio with no success. I am using the jack2-dbus package because I want to use JACK with my DAW. If I run jackd -d alsa -r 44100 -p 2 -c 2 -j -H -P -T -t 10 -A alsa_pcm:device=hw:1,0 -A alsa_pcm:device=hw:1,1, it works fine, but I cannot get any sound with the command jackd -d pulse -r 44100 -p 2 -c 2 -j -H -P -T -t 10 -A pulse:device=alsa_pcm:device=hw:1,0 -A pulse:device=alsa_pcm:device=hw:1,1. I have also tried disabling pulse's module-udev-detect and module-udev-filter, as well as blacklisting the udev rule for pulseaudio. None of these solutions have worked, and I am at a loss as to what to try next.\n\nAnswer: It turns out that the problem was caused by a misconfiguration of the PulseAudio system. Specifically, the `default.pa` file in the `/etc/pulseaudio/` directory was set up to use the wrong device for the audio output.\n\nTo fix the issue, I had to edit the `default.pa` file and change the `load-module` line that loads the `alsa-sink` module to use the correct device name. In my case, the correct device name was `hw:1,0`.\n\nHere's the modified `load-module` line that fixed the issue:\n```\nload-module module"}
