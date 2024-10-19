require 'colorize'
require 'httparty'
require 'socket'
module GameFlowController
	def display_game_menu
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
      	@letter_statuses = ("A".."Z").to_a
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
end