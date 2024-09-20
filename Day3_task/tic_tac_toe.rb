# Player class
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# Game class
class Game
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board = Array.new(9, " ")
    @players = []
    setup_players
    play_game
  end

  def setup_players
    puts "Welcome to Tic Tac Toe!"
    print "Enter name for Player 1 (X): "
    player1_name = gets.chomp
    @players << Player.new(player1_name, "X")

    print "Enter name for Player 2 (O): "
    player2_name = gets.chomp
    @players << Player.new(player2_name, "O")
  end

  def play_game
    current_player = @players.first
    until game_over?
      display_board
      player_move(current_player)
      current_player = switch_player(current_player)
    end
    display_board
    if winner
      puts "Congratulations, #{winner.name}! You have won!"
    else
      puts "It's a tie!"
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def player_move(player)
    position = nil
    loop do
      print "#{player.name} (#{player.symbol}), enter a position (1-9): "
      position = gets.chomp.to_i - 1
      break if valid_move?(position)
      puts "Invalid move. Try again."
    end
    @board[position] = player.symbol
  end

  def valid_move?(position)
    position.between?(0, 8) && @board[position] == " "
  end

  def switch_player(current_player)
    current_player == @players.first ? @players.last : @players.first
  end

  def winner
    WIN_COMBINATIONS.each do |combo|
      if combo.all? { |index| @board[index] == @players.first.symbol }
        return @players.first
      elsif combo.all? { |index| @board[index] == @players.last.symbol }
        return @players.last
      end
    end
    nil
  end

  g = "gnfnb"
  g.gsub!("f","h")
  p g 

  [1,2,3].sum  675

  def full_board?
    !@board.include?(" ")
  end

  def game_over?
    winner || full_board?
  end
end

# Start the game
Game.new
