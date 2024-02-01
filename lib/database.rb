#!/usr/bin/env ruby
# frozen_string_literal: true

# a = PG.connect(host: "ninjabot", user: "postgres")
# a.exec("DROP DATABASE IF EXISTS laudai")
# a.exec("CREATE DATABASE laudai")

require "pgvector"
require "sequel"
require "securerandom"

require "ohm"
require "ohm/contrib"

include Logging

begin
  Ohm.redis = Redic.new(ENV["REDIS"])
  # Ohm.redis.call "FLUSHDB"
  # exit
rescue Ohm::Error => e
  logger.fatal e.to_s
  exit
end

# begin
#   DB = Sequel.connect(ENV["POSTGRES"])

#   DB.run("CREATE EXTENSION IF NOT EXISTS vector")
#   DB.run("CREATE EXTENSION IF NOT EXISTS hstore")

#   DB.extension :pg_array, :pg_hstore
#   DB.extension :pg_json
#   DB.wrap_json_primitives = true
# rescue StandardError => e
#   logger.fatal e.to_s
# end

# begin
#   DB.create_table? (:items) do
#     primary_key :id, type: :Bignum
#     column :name, String
#     column :path, String, unique: true
#     column :type, String
#     index [:name, :path]
#   end

#   DB.create_table? :topics do
#     primary_key :id, type: :Bignum
#     column :name, String
#     column :description, :text
#     column :embedding, "vector(1536)"
#     index :name, unique: true
#   end

#   DB.create_table?(:documents) do
#     primary_key :id, type: :Bignum
#     column :content, String
#     jsonb :metadata
#     column :embedding, "vector(1536)"

#     foreign_key :topic_id, :topics
#     full_text_index :content
#     index %i[metadata embedding]
#   end

#   DB.create_table?(:chunks) do
#     primary_key :id, type: :Bignum
#     column :text, String
#     jsonb :tokenized_text
#     jsonb :sanitized_text
#     foreign_key :document_id, :documents
#     index %i[text document_id]
#   end

#   DB.create_table?(:words) do
#     primary_key :id, type: :Bignum
#     column :word, String
#     column :synsets, "json"
#     column :part_of_speech, String
#     column :named_entity, String
#     foreign_key :chunk_id, :chunks
#     index %i[word chunk_id]
#   end

#   DB.create_table?(:embeddings) do
#     primary_key :id, type: :Bignum
#     column :vector, "vector(1536)"
#     foreign_key :chunk_id, :chunks
#     foreign_key :topic_id, :topics
#     index %i[vector chunk_id topic_id]
#   end
# rescue StandardError => e
#   logger.fatal e.to_s
# end
