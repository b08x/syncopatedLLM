# iterate over each word in the sentence
# if w is a person name, add a node to the graph with the person's name as the label
# add an edge from the previous word to the current word
# if there are more than two words in the sentence and the current word is not a person name or punctuation,
#   add an edge from the previous word to the current word

dependencies = []

tokenized_sentences.each do |words|
  dependencies << {}
end

@graph.add_nodes(dependencies.size)

index = 0

tokenized_sentences.each do |words|
  words.each do |w|
    if w == ',' || w == '.' || w == '?' || w == '!'
      next
    end

    if index == 0
      @graph.nodes[index]['label'] = w
    else
      dependencies[index - 1][dependencies.size - index] = w
    end

    index += 1
  end
end

@graph.add_edges(dependencies)

# print the graph to see the results
puts @graph