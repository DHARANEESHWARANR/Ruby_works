require 'httparty'
require 'faker'
require 'colorize'
require 'socket'

class Wordle
	def display_game_menu   # 1c
		while true
      puts " "
      puts "Enter Your Choice According To The Below Mentioned : "
      puts "Enter 1 ->> To Read The Instructions About The Game "
      puts "Enter 2 ->> To Start  The Game"
      puts "Enter 3 ->> To Exit From The Game"
      user_choice = gets.chomp.to_i
      if user_choice == 1
      	display_instructions
      elsif user_choice == 2
      	@@letter_statuses = ("A".."Z").to_a
      	start_game
      elsif user_choice == 3 
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

  def start_game
  	words = File.readlines('words.txt').map(&:chomp)
  	filtered_five_letter_wordrs = words.select{|word| word.length == 5}
  	random_word_generated = filtered_word.sample
  	puts "The Random Word Generated Is : #{random_word_generated}"
  	getting_user_guesses(random_word_generated)
  end

  def getting_user_guesses(random_word)         #2c
    number_of_chances = 5
    (1..number_of_chances).each do |current_chance|
      puts "\nChance #{current_chance}:"
      print "Enter the Word You Guess: "
      guess_word = gets.chomp
      status_of_evaluation = evaluate_user_guesses(guess_word)
      if status_of_evaluation == "redo"
      	redo  
      elsif status_of_evaluation == "success"
      	return 
    end
    puts "Sorry, You Lose The Game.".red
    puts "The Correct Word is #{random_word}."
  end
  
  def evaluate_user_guesses(guess_word)
  	if guess_word.length != 5
        puts "! Invalid Word Length. Enter a 5 Letter Word.".red
        return "redo"
      elsif random_word == guess_word
        puts "Congratulations! You Guessed The Word.".green
        puts "You Are A Winner.".green
        return "success"
      elsif valid_five_letter_word?(guess_word)
        provide_feedback(random_word, guess_word)
      else
        puts "The Guess Word does not exist in the dictionary.".red
        puts "Enter a valid 5-letter English word.".red
        return "redo"
      end
  end

  
  def valid_five_letter_word?(word)
   word.match?(/^[a-zA-Z]+$/) && word_exists?(word)
  end

  def word_exists?(word)
   if internet_connected?
   	response = HTTParty.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
   	return response.code == 200
   else
   	puts "Internet Is Not Connected"
   end
  end

  def display_letter_statuses         #3c
  	puts ""
    character_count = 0                      
    for character in @@letter_statuses         #4c
      if count <10
        print "#{character} | "
        character_count =character_count+1   
      else 
        character_count = 0
        puts " "
      end
    end
    puts ""
  end

  def internet_connected?
  	begin
    # Open a TCP connection to Google's DNS server (8.8.8.8) on port 53
    Socket.tcp("8.8.8.8", 53, connect_timeout: 5).close
    true
    rescue SocketError, Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ETIMEDOUT
    false
  end
  end

  def provide_feedback(random_word,guess_word)
  	frequency_of_letters = random_word.chars.each_with_object(Hash.new(0)) { |letter, counts| counts[letter] += 1 }
  	puts "Your guess: #{guess_word} was evaluated. Here's the breakdown:".blue
  	puts "--------------------"
  	guess_word_array = guess_word.split("")
  	guess_word_array.each_with_index do |char,index|
  		if char == random_word[index] 
  			frequency_of_letters[char] = frequency_of_letters[char] -1
  			@@letter_statuses[char.ord frequency_of_letters- 97] = @@letter_statuses[char.ord - 97].green
  			print "#{char} | ".greens
  		elsif random_word.include?(char) && frequency[char] >=1
  			frequency_of_letters[char] = frequency_of_letters[char] -1
  			@@letter_statuses[char.ord - 97] = @@letter_statuses[char.ord - 97].yellow
  			print "#{char}| ".yellow
  		else
  			@@letter_statuses[char.ord - 97] = @@letter_statuses[char.ord - 97].red
  			print "#{char} | ".red
  		end
  	end
  	puts "\n"
  	puts "--------------------"
  	display_letter_statuses
  		puts "Use the above feedback to refine your next guess!".blue
  end

end

game_obj = Wordle.new

game_obj.display_game_menu