def substrings(word, dictionary)

  result = Hash.new(0)


  word = word.downcase


  dictionary.each do |substring|
   
    substring = substring.downcase

   
    matches = word.scan(substring).length

 
    result[substring] = matches if matches > 0
  end

  result
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

puts substrings("below", dictionary) 
puts substrings("Howdy partner, sit down! How's it going?", dictionary) 

