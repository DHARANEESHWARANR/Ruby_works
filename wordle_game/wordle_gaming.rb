
class Wordle
	require 'httparty'
	require 'faker'
	require 'colorize'
	def display_choices
		while true
      puts " "
      puts "Enter Your Choice According To The Below Mentioned : "
      puts "Enter 1 ->> To Read The Instructions About The Game "
      puts "Enter 2 ->> To Start  The Game"
      puts "Enter 3 ->> To Exit From The Game"
      choice = gets.chomp.to_i
      if choice == 1
      	display_instructions
      elsif choice == 2
      	@@array = ("A".."Z").to_a
      	start_gaming
      elsif choice == 3 
      	break
      else
        puts "!Invalid Number Entered"
        puts "Enter Number From 1-3"
      end
    end
  end

  def display_instructions
  	puts "\n--- Wordle Game Instructions ---\n\n".blue
    puts "The game randomly selects a 5-letter word from a predefined list.".green
    puts "-> The player has 5 attempts to guess the word.".green
    puts "-> After each guess, the game provides feedback:".green
    puts "   - Correct letter in the correct position: The letter is marked with Green.".yellow
    puts "   - Correct letter in the wrong position: The letter is marked with Yellow.".yellow
    puts "   - Wrong letter: The letter is marked with Red.".yellow
    puts "\nGood luck, and have fun playing!\n".green
  end

  # def start_game
  # 	#Loop until a 5-letter word is generated
  # 	puts "\n--- Game Started , Get Ready Folks ---\n\n".blue
  # 	random_word = ''
  # 	loop do
  # 	  random_word = Faker::Lorem.word
  # 	  break if random_word.length == 5 
  # 	end
  # 	puts "Your 5-letter random word is: #{random_word}"  #for reference to check
  # 	manage_attempts(random_word)
  # end

  #above is randomely generating availble 5 letter word

  def start_gaming
  	words = File.readlines('words.txt').map(&:chomp)
  	filtered_word = words.select{|word| word.length == 5}
  	random_word = filtered_word.sample
  	puts "The Random Word Generated Is : #{random_word}"
  	manage_attempts(random_word)
  end

  def manage_attempts(random_word)
    number_of_chances = 5
    (1..number_of_chances).each do |current_chance|
      puts "\nChance #{current_chance}:"
      print "Enter the Word You Guess: "
      guess_word = gets.chomp
      if guess_word.length != 5
        puts "! Invalid Word Length. Enter a 5 Letter Word.".red
        next
      elsif random_word == guess_word
        puts "Congratulations! You Guessed The Word.".green
        puts "You Are A Winner.".green
        return
      elsif valid_five_letter_word?(guess_word)
        provide_feedback(random_word, guess_word)
      else
        puts "The Guess Word does not exist in the dictionary.".red
        puts "Enter a valid 5-letter English word.".red
        next
      end
    end
    puts "Sorry, You Lose The Game.".red
    puts "The Correct Word is #{random_word}."
  end

  def provide_feedback(random_word,guess_word)
  	frequency = random_word.chars.each_with_object(Hash.new(0)) { |letter, counts| counts[letter] += 1 }
  	puts "Your guess: #{guess_word} was evaluated. Here's the breakdown:".blue
  	puts "--------------------"
  	guess_word_arr = guess_word.split("")
  	guess_word_arr.each_with_index do |char,index|
  		if char == random_word[index] 
  			frequency[char] = frequency[char] -1
  			@@array[char.ord - 97] = @@array[char.ord - 97].green
  			print "#{char} | ".green
  		elsif random_word.include?(char) && frequency[char] >=1
  			frequency[char] = frequency[char] -1
  			@@array[char.ord - 97] = @@array[char.ord - 97].yellow
  			print "#{char}| ".yellow
  		else
  			@@array[char.ord - 97] = @@array[char.ord - 97].red
  			print "#{char} | ".red
  		end
  	end
  	puts "\n"
  	puts "--------------------"
  	display_alpha_board
  		puts "Use the above feedback to refine your next guess!".blue
  end
  
  def valid_five_letter_word?(word)
   word.match?(/^[a-zA-Z]+$/) && word_exists?(word)
  end

  def word_exists?(word)
   response = HTTParty.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
   response.code == 200
  end

  def display_alpha_board
  	puts ""
    count = 0
    for arr in @@array
      if count <10
        print "#{arr} | "
        count =count+1   
      else 
        count = 0
        puts " "
      end
    end
    puts ""
  end

end

game_obj = Wordle.new

game_obj.display_choices