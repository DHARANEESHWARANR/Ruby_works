module GameFeedback
	def display_letter_statuses
		puts ""
    character_count = 0                      
    for character in @letter_statuses
    	if character_count <10
        print "#{character} | "
        character_count =character_count+1   
      else 
        character_count = 0
        puts " "
      end
    end
    puts ""
  end

   def provide_feedback(random_word,guess_word)
   	frequency_of_letters = random_word.chars.each_with_object(Hash.new(0)) { |letter, counts| counts[letter] += 1 }
  	puts "Your guess: #{guess_word} was evaluated. Here's the breakdown:".blue
  	puts "--------------------"
  	guess_word_array = guess_word.split("")
  	guess_word_array.each_with_index do |char,index|
  		if char == random_word[index] 
  			frequency_of_letters[char] = frequency_of_letters[char] -1
  			@letter_statuses[char.ord - 97] = @letter_statuses[char.ord - 97].green
  			print "#{char} | ".green
  		elsif random_word.include?(char) && frequency_of_letters[char] >=1
  			frequency_of_letters[char] = frequency_of_letters[char] -1
  			@letter_statuses[char.ord - 97] = @letter_statuses[char.ord - 97].yellow
  			print "#{char}| ".yellow
  		else
  			@letter_statuses[char.ord - 97] = @letter_statuses[char.ord - 97].red
  			print "#{char} | ".red
  		end
    end
  	puts "\n"
  	puts "--------------------"
  	display_letter_statuses
  	puts "Use the above feedback to refine your next guess!".blue
    end
end