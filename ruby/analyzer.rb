stop_words = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

# Count the characters
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/, '').length

# Count the words, sentences, paragraphs
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

# Make a list of words in the text that aren't stop words count them, and
# work out the percentage of non-stop words against all words.
words = text.scan(/\w+/)
goodwords = words.select { |word| !stop_words.include?(word) }
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length/3
ideal_sentences = sentences_sorted.slice(one_third, one_third+1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }


puts "#{line_count} lines\n#{total_characters} chars"
puts "#{total_characters_nospaces} characters (excluding spaces)\n#{word_count} count of words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count/paragraph_count} sentences per paragraph (average)"
puts "#{word_count/sentence_count} words per sentence (average)"
puts "#{((goodwords.length.to_f / words.length.to_f) * 100).to_i} goodwords (percentage)"
puts "Summary:\n\n"+ideal_sentences.join(". ")