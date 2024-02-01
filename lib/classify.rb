#!/usr/bin/env ruby
# frozen_string_literal: false

require "openai"
require "google_palm_api"
require "langchainrb"


# hash of topics

## example prompt to classify input requests/query
https://raw.githubusercontent.com/chtmp223/topicGPT/main/prompt/assignment.txt

1. Categorize a given sentence into entity categories. Each sentence can have more than one category.

2. Classify whether a sentence requires context. Context is required when additional information about the content of a {{chunk}} is required to fulfill the task described in the sentence.
- Adding an image about a given topic does not require context.
- Adding new text needs context to decide where to place the text on the current slide.

...
Let’s think step by step. Here are some examples:

User: Make the title text on this slide red
Assistant:
  Categories: text
  Thoughts: We can select the title text and make it red without knowing the existing text properties. Therefore we do not need context.
  RequiresContext: false

User: Add text that’s a poem about the life of a high school student with emojis.
Assistant:
  Categories: text Thoughts: We need to know whether there is existing text on the slide to add the new poem. Therefore we need context.
  RequiresContext: true

...
