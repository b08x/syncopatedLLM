#!/usr/bin/env ruby
# frozen_string_literal: false

# require "sequel"

# DB = Sequel.connect('postgres://postgres@tinybot.syncopated.net/monadic')
class Topics < Sequel::Model
  one_to_many :documents
  one_to_many :chunks
end

class Documents < Sequel::Model
  many_to_one :topic
  many_to_many :chunks
end

# class Websites < Sequel::Model
# end

class Chunks < Sequel::Model
  many_to_one :document
  many_to_one :topic
  one_to_many :words
  one_to_many :embeddings
end

class Words < Sequel::Model
  many_to_one :chunk
  one_to_many :embeddings
end

class Embeddings < Sequel::Model
  many_to_one :chunk
  many_to_one :topic
  many_to_one :topic
end
