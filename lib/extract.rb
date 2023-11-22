#!/usr/bin/env ruby
# frozen_string_literal: false

require "kramdown"
require "poppler"
require "redcarpet"
require "redcarpet/render_strip"

# https://github.com/coreyti/beckett - A Markdown-to-JSON/HTML5/Ruby-Hash Renderer.

# https://www.rubydoc.info/gems/pdf_paradise/0.2.2 - extracting a .pdf page, converting .pdf page, merging .pdf files, splitting .pdf files, setting the title of a .pdf page and similar actions.

# PdfParadise.does_this_pdf_file_have_a_title? "foobar.pdf" # => true

# PdfParadise.burst('foobar.pdf') - Splitting a single pdf file into individual several .pdf files

class MD2Text
  include Logging
  attr_reader :file_path
  attr_accessor :text

  def initialize(file_path)
    @file_path = file_path
    @file_name = File.basename(file_path)
    @text = ""
    extract
  end

  def extract
    @text = Kramdown::Document.new(File.read(@file_path)).to_s
  end
end

class PDF2Text
  include Logging

  THREADS = 4

  attr_reader :file_path
  attr_accessor :text

  # Initializes the PDF2Text class
  def initialize(file_path)
    @file_path = file_path
    @file_name = File.basename(file_path)
    @text = ""
    extract
  end

  # Extracts the text from the PDF file
  def extract
    doc = Poppler::Document.new(@file_path)
    @text = ""

    Parallel.each(0...doc.n_pages, in_threads: THREADS) do |page_num|
      page = doc.get_page(page_num)
      @text += "#{page.get_text}\n"
    end
    # logger.debug("text_data: #{@text}")
    @text
  end
end
