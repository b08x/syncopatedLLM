#!/usr/bin/env ruby
# frozen_string_literal: false

APP_ROOT = File.expand_path("../../", __FILE__)

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

require "version"
require "log"

module Laudllm
  class Error < StandardError; end
  # Your code goes here...
end

puts "hey"
