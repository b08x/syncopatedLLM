#!/usr/bin/env ruby
# frozen_string_literal: true

require "google_palm_api"
require "langchainrb"

google_palm = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"])
