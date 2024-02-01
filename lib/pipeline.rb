#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pragmatic_segmenter'
require 'pragmatic_tokenizer'
require 'lemmatizer'
require 'networkx'
require 'composable_operations'

require_relative 'pipeline/entities'
require_relative 'pipeline/hypernyms'
require_relative 'pipeline/ldamodeler'

TEST = :all


class Tokenizer < ComposableOperations::Operation
  processes :chunks

  property :punct, default: :all, required: true
  property :stopwords, default: false, required: true

  before do
    @options = {
      remove_stop_words: stopwords,
      punctuation: punct,
      numbers: :all,
      minimum_length: 0,
      remove_emoji: true,
      remove_emails: true,
      remove_urls: true,
      remove_domains: true,
      expand_contractions: true,
      clean: false,
      mentions: :keep_original,
      hashtags: :keep_original,
      classic_filter: true,
      downcase: false,
      long_word_split: 20
    }
  end

  def execute
    chunks.segment.map do |segment|
      PragmaticTokenizer::Tokenizer.new(@options).tokenize(segment)
    end
  end
end

class Lemma < ComposableOperations::Operation
  processes :word

  before do
    @lem = Lemmatizer.new
  end

  def execute
    @lem.lemma(word, :noun)
  end
end

class Segmenter < ComposableOperations::Operation
  processes :text

  def execute
    PragmaticSegmenter::Segmenter.new(text: text)
  end
end



text = <<~TEXT
  Based on the output of the `aplay -l` command, it seems that your system is recognizing multiple audio devices. The JACK server is using the USB audio device (hw:1,0), but your system also has an HDAudio device (hw:0,0 and hw:0,1)
  If you're not hearing any sound, it's possible that the wrong audio device is selected as the default in your Ubuntu sound settings. Here's how you can check and change the default audio device:
  Open the Sound settings in Ubuntu. You can do this by clicking on the volume icon in the top-right corner of the screen and then clicking on 'Sound Settings' or 'Settings' and then 'Sound'
    In the Sound settings, look for the 'Output' section. Here, you should see a list of all recognized audio devices.
    Check which device is currently selected. If the USB audio device (hw:1,0) is selected, try selecting the HDAudio device (hw:0,0 or hw:0,1) instead
    After changing the output device, try playing sound again to see if the issue is resolved.

  If the issue persists, you may need to adjust the configuration of the JACK server to use the correct audio device. You can do this by modifying the .jackdrc file or using the jack_control 
  command to change the device option

  Remember to restart the JACK server after making any changes to its configuration. You can do this by using the jack_control stop and jack_control start commands
TEXT

class Chunker < ComposableOperations::ComposedOperation
  use Segmenter
  # use Tokenizer, punct: :none, stopwords: true
  use Tokenizer
end

tokenized_sentences = Chunker.perform(text)

# tokenized_sentences.each do |words|
#   words.each do |word|
#     p word
#   end
# end

@graph = NetworkX::Graph.new

tokenized_sentences.map! { |chunk| DependencyParse.perform(chunk) }

tokenized_sentences.each do |words|
  puts "--------------------------"
  puts "\n\n"
  puts "parsing #{words}...."

  words.each do |w|  

    puts "word: #{w}\n"

    word = w.keys[0]

    partofspeech = w.values[0][:pos]

    puts "POS: #{partofspeech}"

    #next unless partofspeech == :noun

    if partofspeech.to_s =~ /nn|nnp/
      @graph.add_node(word)

      # lemma = Lemma.perform(w.downcase)
      lemma = w.values[0][:lemma]

      puts "lemma: #{lemma}"

      hypernyms = WordSenses.perform(word)

      next if hypernyms.nil?

      # p hypernyms

      hypernyms.each do |hypernym|
        puts "hypernym: #{hypernym}"
      end
      puts "---------------------------------"
    end
  end
  
  puts "--------------------------------"
  # test = Embeddings.perform(words)
  #p test
  puts "\n"
  puts "--------------------------------"
  puts "\n\n"

end



# class Topic < ComposableOperations::ComposedOperation
#   use Modeler
# end

# topics = Topic.perform(chunked)

# p topics



# seg = Segmenter.new(text).perform

# seg.segment.each do |t|
#   tokenize = Tokenizer.new(t).perform
#   p tokenize
#   puts "-------"
#   puts "\n"
# end

#p tokenize

