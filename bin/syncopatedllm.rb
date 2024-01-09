#!/usr/bin/env ruby
# frozen_string_literal: false

APP_ROOT = File.expand_path("..", __dir__)

lib_dir = File.expand_path(File.join(__dir__, "..", "lib"))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

require "version"
require "parallel"
require "mimemagic"
require "optimist"
require "dotenv"
require "parallel"

Dotenv.load(File.join(APP_ROOT, ".env"))

require "log"
require "glob"

require "dry/monads"

require "database"
require "db/ohm_objects"
require "db/pg_objects"

require "openai"
require "langchainrb"
require "google_palm_api"
require "cohere"

require 'fileutils'
require "pdf_paradise"
require "extract"

#
# <Description>
#
module SyncopatedLLM
  include Logging

  #
  # <Description>
  #
  class Item
    attr_reader :path, :type, :name, :extension

    def initialize(path)
      @path = Pathname.new(path).cleanpath.to_s
      begin
        mime = MimeMagic.by_magic(File.open(@path))
        @type = mime.type unless mime.nil?
      rescue NoMethodError
        @type = MimeMagic.by_path(File.open(@path)).type
      end
      @extension = File.extname(path)
      @name = File.basename(path, ".").gsub(@extension, "")
    end
  end

  #
  # <Description>
  #
  module Colors
    module_function

    require "tty-config"

    def set(theme)
      config = TTY::Config.new
      config.append_path(APP_ROOT)
      config.read
      config.fetch(:colors)[theme]
    end
  end

  #
  # <Description>
  #

  class Import
    include Logging

    attr_accessor :file, :content

    def initialize(path)
      @file = SyncopatedLLM::Item.new(path)
      extract
    end

    def extract
      case @file.type
      when "application/pdf"
        path = Pathname.new(@file.path)
        FileUtils.copy_file @file.path, "/tmp/testing/#{@file.name}.pdf"
        Dir.chdir("/tmp/testing") do
          PdfParadise.burst("'/tmp/testing/#{@file.name.shellescape}.pdf'")
        end
        #@content = PDF2Text.new(@file.path).text
        #p @content
      else
        p @file.type
      end
    end

  end #end import class
end #end SyncopatedLLM module

THEME = SyncopatedLLM::Colors.set("default")

SUB_COMMANDS = %w[import log].freeze

global_opts = Optimist.options do
  banner "SyncopatedLLM document processing utility"
  opt :dry_run, "Don't actually do anything", short: "-n"
  stop_on SUB_COMMANDS
end

cmd = ARGV.shift # get the subcommand

unless cmd.nil?

  cmd_opts = case cmd
             when "import" # parse delete options
               Optimist.options do
                 opt :type, "Type of Document(s)", type: :string
               end
             when "log" # parse copy options
               Optimist.options do
                 opt :debug, "Logger Debug mode"
               end
             else
               Optimist.die "either there wasn't a subcommand provided or it was provided incorrectly. #{cmd.inspect}"
             end

  puts "Global options: #{global_opts.inspect}"
  puts "Subcommand: #{cmd.inspect}"
  puts "Subcommand options: #{cmd_opts.inspect}"
  puts "File Path(s): #{ARGV.inspect}"

  path = Pathname.new(ARGV[0])

  p path.cleanpath.to_s
  
  
  SyncopatedLLM::Import.new(path.cleanpath.to_s) unless ARGV.empty?

end
