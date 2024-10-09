
class Wordle
	require 'httparty'
	require 'faker'
	require 'colorize'
	def initializes
	end
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
      	start_game
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
    puts "-> The player has 6 attempts to guess the word.".green
    puts "-> After each guess, the game provides feedback:".green
    puts "   - Correct letter in the correct position: The letter is marked with Green.".yellow
    puts "   - Correct letter in the wrong position: The letter is marked with Yellow.".yellow
    puts "   - Wrong letter: The letter is marked with Red.".yellow
    puts "\nGood luck, and have fun playing!\n".green
  end

  def start_game
  	#Loop until a 5-letter word is generated
  	puts "\n--- Game Started , Get Ready Folks ---\n\n".blue
  	random_word = ''
  	loop do
  	  random_word = Faker::Lorem.word
  	  break if random_word.length == 5
  	end
  	puts "Your 5-letter random word is: #{random_word}"
  	manage_attempts(random_word)
  end

  def manage_attempts(random_word)
  	number_of_chances = 5
  	current_chance = 1
  	while number_of_chances > 0   #for checking total number of Chances
  		while true                  # is the enterd one is five lettered word
  			puts ""
  			puts "Chance #{current_chance} :"
  			print "Enter the Word You Guess : "
  			guess_word = gets.chomp
  			if guess_word.length!=5
  				puts "! Invalid Word Length Is Exceeding".red
  				puts "! Enter 5 Letter Word".red
  				next
  			elsif random_word == guess_word
  				provide_feedback(random_word,guess_word)
  				puts "Congratulations You Are a Winner".green
  				return
  			else
  				if valid_five_letter_word?(guess_word)
  					provide_feedback(random_word,guess_word)
  				else
            puts "The Guess Word is Not Exists in Dictionary".red
            puts "Enter The Valid 5 Letter English Word".red
            next
  				end
  				break

  			end
  		end
  		number_of_chances=number_of_chances-1
  		current_chance =current_chance+=1
  	end
  	if number_of_chances == 0
  		puts "Sorry You Lose The Game".red
  	end
  end

  def provide_feedback(random_word,guess_word)
  	puts "Not Correct, Refer This for Upcoming Chance".yellow
  	puts "--------------------"
  	guess_word_arr = guess_word.split("")
  	guess_word_arr.each_with_index do |char,index|
  		if char == random_word[index]
  			print "#{char} | ".green
  		elsif random_word.include?(char)
  			print "#{char}| ".yellow
  		else
  			print "#{char} | ".red
  		end
  	end
  	puts "\n"
  	puts "--------------------"
  end
  
  def valid_five_letter_word?(word)
   word.match?(/^[a-zA-Z]+$/) && word_exists?(word)
  end

  def word_exists?(word)
   response = HTTParty.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
   response.code == 200
  end

end

game_obj = Wordle.new

game_obj.display_choices