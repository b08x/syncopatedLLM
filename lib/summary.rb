#!/usr/bin/env ruby
# frozen_string_literal: false

require "openai"
require "google_palm_api"
require "cohere"
require "langchainrb"

# Function to generate a prompt template for summarizing text
def generate_summarization_prompt_template(max_tokens)
  prompt_template = Langchain::Prompt::PromptTemplate.new(
    template: "Summarize the following text in #{max_tokens} tokens or less:\n{text}",
    input_variables: ["text"]
  )
end

# Function to save the prompt template to a file
def save_prompt_template(prompt_template, file_path)
  prompt_template.save(file_path: file_path)
end

# Function to load the summarization prompt template
def load_summarization_prompt_template
  prompt_template = Langchain::Prompt.load_from_path(file_path: "summarization_prompt_template.json")

  prompt_template
end

# Function to generate a summary using the summarization prompt template
def generate_summary(text, prompt_template, llm)
  prompt = prompt_template.format(text: text)
  response = llm.complete(prompt: prompt)

  #response.raw_response["choices"][0]["message"]["content"]
  response
end

# Example Usage
max_tokens = 120
prompt_template = generate_summarization_prompt_template(max_tokens)

PALM = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"], default_options: {
  temperature: 0.4,
  dimension: 768, # This is what the `embedding-gecko-001` model generates
  completion_model_name: "text-bison-001",
  chat_completion_model_name: "chat-bison-001",
  embeddings_model_name: "embedding-gecko-001"
})

OPENAI = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], default_options: {
  n: 1,
  temperature: 0.0,
  completion_model_name: "gpt-3.5-turbo-1106",
  chat_completion_model_name: "gpt-3.5-turbo-1106",
  embeddings_model_name: "text-embedding-ada-002",
  dimension: 1536
})

# COHERE = Langchain::LLM::Cohere.new(api_key: ENV["COHERE_API_KEY"], default_options: {
#   temperature: 0.0,
#   completion_model_name: "command",
#   embeddings_model_name: "small",
#   dimension: 1024,
#   truncate: "START"
# })


text = "The tree-of-thoughts framework looks to address these issues in reasoning for more complex problems by essentially branching out every thought generation into multiple possibilities. The strongest thought or step is chosen at every level in the thought tree and executed accordingly. Since we're dealing with a tree structure, there can be many search techniques used to find the most desired path, however, it seems like Breadth First Search is the simpler and most like the way humans would tackle the execution of a task."

summary = generate_summary(text, prompt_template, PALM)

puts summary.raw_response
# "The internet originated in the 1960s as a US military network called ARPANET. In the 1970s, the TCP/IP protocol enabled different networks to connect, forming the modern internet."
