# frozen_string_literal: true

require_relative "lib/version"

Gem::Specification.new do |spec|
  spec.name = "laudllm"
  spec.version = Laudllm::VERSION
  spec.authors = ["b08x"]
  spec.email = ["rwpannick@gmail.com"]

  spec.summary = "NLP Document Processor for LLM Applications"
  spec.description = "Load and Query collections of documents"
  spec.homepage = "https://b08x.github.io/laudllm"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/b08x/laudllm.git"
  spec.metadata["changelog_uri"] = "https://github.com/b08x/laudllm/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rb_sys"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "solargraph"

  spec.add_dependency "beckett"
  spec.add_dependency "chroma-db"
  spec.add_dependency "composable_operations"
  spec.add_dependency "dotenv"
  spec.add_dependency "drydock"
  spec.add_dependency "dry-monads"
  spec.add_dependency "engtagger"
  spec.add_dependency "google_palm_api"
  spec.add_dependency "highline"
  spec.add_dependency "json"
  spec.add_dependency "jsonl"
  spec.add_dependency "kramdown"
  spec.add_dependency "langchainrb"
  spec.add_dependency "lemmatizer"
  spec.add_dependency "llm_memory"
  spec.add_dependency "logging"
  spec.add_dependency "mimemagic"
  spec.add_dependency "nokogiri"
  spec.add_dependency "ohm"
  spec.add_dependency "ohm-contrib"
  spec.add_dependency "open3"
  spec.add_dependency "open4"
  spec.add_dependency "open-uri"
  spec.add_dependency "optimist"
  spec.add_dependency "osc-ruby"
  spec.add_dependency "parallel"
  spec.add_dependency "pdf-reader"
  spec.add_dependency "pdf_paradise"
  spec.add_dependency "pgvector"
  spec.add_dependency "polars"
  spec.add_dependency "polars-df"
  spec.add_dependency "poppler"
  spec.add_dependency "pragmatic_segmenter"
  spec.add_dependency "pragmatic_tokenizer"
  spec.add_dependency "redcarpet"
  spec.add_dependency "redic"
  spec.add_dependency "redis"
  spec.add_dependency "ruby-openai"
  spec.add_dependency "ruby-spacy"
  spec.add_dependency "safe_ruby"
  spec.add_dependency "sequel"
  spec.add_dependency "solargraph"
  spec.add_dependency "summarize"
  spec.add_dependency "syntax_tree"
  spec.add_dependency "tomoto"
  spec.add_dependency "tty-config"
  spec.add_dependency "tty-prompt"
  spec.add_dependency "typecheck"
  spec.add_dependency "vega"
  spec.add_dependency "verbal_expressions"
  spec.add_dependency "wordnet"
  spec.add_dependency "wordnet-defaultdb"
end
