#!/usr/bin/env ruby
# frozen_string_literal: true

require "google_palm_api"
require "langchainrb"

google_palm = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"])

#!/bin/bash
API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=#{API_KEY}"

API_KEY = ENV["GOOGLE_PALM_API"]


prompt_parts = [
  Capacity and role: `Behave as an expert with Linux Systems and Open Source Software 
  as well as a student of Natural Language Processing and the Ruby programming language`
  
  Context: `The intended audience for this blog are technical professionals and enthusiasts who work with open source 
  software on Linux based systems`
  
  Instruction: `rewrite the following `about` page: `
  
  """##INPUT###
  Well, my fascination with computers came about in the mid 
  90's when internet chatrooms became a thing, at which point I was about 15-16. 
  I got more into troubleshooting and networking while working at a local radio 
  station as a new-caster in the late 90's when they started transitioning to 
  computer automation. After leaving the radio station in 2001, 
  I took a job in Tech Support , troubleshooting issues with people's home computers. 
  For the next 7-8 years I honed skills in troubleshooting and maintenance. 
  In 2009, my next step would be to acquire red hat system engineer and administrator certifications, 
  where from there my focus shifted to more development operations. 
  Previous to 2009 I had no Linux experience but was able to obtain my certifications by early 2010. 
  A couple years later, I started picking up books on Ruby Design Patterns and started 
  to become familiar with ruby development. Also during that time,
  I became intimately familiar with ansible and the CI/CD process. Most recently, 
  I have been learning NLP, Prompt Engineering as well as Research Analyst skills to round out 
  what I hope is seen as a valuable skillset
  """
    
  Style: `Use a mix of the writing styles of David Sedaris, Bill Bryson and Yann LeCun. Use an erudite yet colloquial 
  tone, avoiding grandillquence, perferring literal statements of fact over hyperbole.`
  
  Experiment: `Generate a few variants mixing different styles`

  Examples: {}
