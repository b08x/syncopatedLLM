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

Dotenv.load(File.join(APP_ROOT, ".env"))

require "log"
require "glob"

require "dry/monads"

require "database"
require "db/ohm_objects"
require "db/pg_objects"

require "openai"
require "langchain"
require "extract"

#
# <Description>
#
module Laudllm
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

    def initialize
      files = []

      ARGV.each do |source|
        if File.directory?(source)
          files = Glob.documents(source)
        elsif File.file?(source)
          puts "its a file"
          files << source
        else
          logger.fatal "#{source} is neither a file nor directory, exiting"
        end
      end

      files.map! { |path| Laudllm::Item.new(path) }

      files.each do |file|

        begin
          if !Document.find(path: file.path).first.nil? && Document.find(path: file.path).first
            unless Document.find(path: file.path).first.processed == "false"
              logger.info("#{file.path} already exists, skipping import")
              next
            end
          end
        rescue ArgumentError => e
          logger.info("#{file} #{e.message}")
        end

        begin

          doc = Document.create(
            path: file.path,
            name: file.name,
            type: file.type
          )

          content = doc.extract_text(doc.path, doc.type)

          begin
            unless content.empty? || content.class != String
              doc.update(content: content)
              doc.save
            end
          rescue NoMethodError => e
            logger.fatal("Content is not a string of text...")
            exit
          end

          logger.debug "added #{file.path}"
        rescue Ohm::UniqueIndexViolation => e
          logger.warn "<#{file.path}> already exists in database\n#{e.message}"
          doc = Document.find(path: file.path).first
          content = doc.extract_text(file.path, file.type)
          begin
            unless content.empty? || content.class != String
              doc.update(content: content)
              doc.save
            end
          rescue NoMethodError => e
            logger.warn("Content is not a string of text...")
            p doc.path
            p content
            exit
          end

        end

      end
    end

  end #end import class

end #end laudllm module

THEME = Laudllm::Colors.set("default")

SUB_COMMANDS = %w[import log].freeze

global_opts = Optimist.options do
  banner "laudllm document processing utility"
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

  Laudllm::Import.new unless ARGV.empty?

end
