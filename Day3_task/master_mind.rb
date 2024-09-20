class Mastermind
  def initialize
    @colors = %w[pink purple violet blue lavendar green]
    @code = Array.new(4) { @colors.sample }
    @max_attempts = 12
  end
  def play
    @max_attempts.times do |attempt|
      puts "#{@max_attempts - attempt} attempts left"
      guess = get_guess
      feedback = get_feedback(guess)
      puts "#{feedback[:correct]} correct, #{feedback[:incorrect]} in the wrong position"
      if feedback[:correct] == 4
        puts "Correct #{@code.join(' ')}"
        return
      end
    end
    puts "no attempts left! The code is: #{@code.join(' ')}"
  end
  def get_guess
    loop do
      puts "Enter your guess (4 colors):"
      guess = gets.chomp.split
      return guess if valid_guess?(guess)
      puts "Invalid guess. Try again."
    end
  end
  def valid_guess?(guess)
    guess.length == 4 && guess.all? { |color| @colors.include?(color) }
  end
  def get_feedback(guess)
    correct = guess.each_index.count { |i| guess[i] == @code[i] }
    incorrect = (guess & @code).size - correct
    { correct: correct, incorrect: incorrect }
  end
end
guess_game = Mastermind.new
guess_game.play









