require 'httparty'
require 'colorize'
require 'socket'
module GuessingLogicHandler
  def start_game
    words = File.readlines('words.txt').map(&:chomp)
    filtered_five_letter_words = words.select{|word| word.length == 5}
    random_word_generated = filtered_five_letter_words.sample
    puts "The Random Word Generated Is : #{random_word_generated}"
    getting_user_guesses(random_word_generated)
  end

  def getting_user_guesses(random_word)         
    number_of_chances = 5
    (1..number_of_chances).each do |current_chance|
      puts "\nChance #{current_chance}:"
      print "Enter the Word You Guess: "
      guess_word = gets.chomp
      status_of_evaluation = evaluate_user_guesses(guess_word,random_word)
      if status_of_evaluation == "redo"
      	redo  
      elsif status_of_evaluation == "success"
      	return 
      end
    end
    puts "Sorry, You Lose The Game.".red
    puts "The Correct Word is #{random_word}."
  end

  def evaluate_user_guesses(guess_word,random_word)
    if guess_word.match?(/^\d+$/)         #example 1234
      puts "Unfortunately You enter the number. Try again.".yellow
      return "redo"
    elsif guess_word.match?(/^(?=.*[a-zA-Z])(?=.*\d)/)        #example 12agd32
      puts "Oops! Your word contains both letters and numbers (e.g., #{guess_word}). Please enter a valid 5-letter word without numbers.".yellow
      return "redo"
    elsif guess_word.length !=5     # "" or fetds (invalid word)
      guess_word.length == 0 ? (puts "Oops! You forgot to enter a word. Try again.".yellow) : (puts "Invalid Word And length mismatch! Please enter exactly 5 letters.".yellow)
      return "redo"
    elsif random_word == guess_word   #if correct
      puts "Congratulations! You Guessed The Word.\nYou Are A Winner.".green
      return "success"
    elsif valid_five_letter_word?(guess_word)
      provide_feedback(random_word, guess_word)
    else
      puts "The Guess Word does not exist in the dictionary.\n Enter a valid 5-letter  word".red
      return "redo"
    end
  end
end


