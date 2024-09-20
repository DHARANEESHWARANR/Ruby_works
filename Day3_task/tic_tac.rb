class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @players = []
    @boards = Array.new(9, " ")
    @winning = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
    get_players
  end

  def get_players
    puts "Enter the player name 1: "
    player1 = gets.chomp
    @players << Player.new(player1, "X")

    puts "Enter the player name 2: "
    player2 = gets.chomp
    @players << Player.new(player2, "O")

    play_game
  end

  #play game method
  
  def play_game
    current_player = @players.first
    until game_over?
      display_board
      player_move(current_player)
      current_player = switch_player(current_player)
    end

    if winner
      puts "The winner is #{winner.name}"
    else 
      puts "The match is tie"
    end
    
  end

  def switch_player(current_player)
    current_player == @players.first ? @players.last: @players.first
  end

  def player_move(current_player)
    loop do
      puts "#{current_player.name} #{current_player.symbol} enter 1-9"
      pos = gets.chomp.to_i-1
      if @boards[pos]==" "
        @boards[pos] = current_player.symbol
        break
      else
        puts "Enter the valid Number"
      end
    end
  end


  def display_board
    puts " #{@boards[0]} | #{@boards[1]} | #{@boards[2]} "
    puts "-----------"
    puts " #{@boards[3]} | #{@boards[4]} | #{@boards[5]} "
    puts "-----------"
    puts " #{@boards[6]} | #{@boards[7]} | #{@boards[8]} "
  end

 
  def winner 
    @winning.each do |combo|
      if combo.all? {|index| @boards[index] == @players.first.symbol}
        return @players.first
      elsif 
        combo.all? {|index| @boards[index] == @players.last.symbol}
        return @players.last
      end
    end
    nil
  end


  def game_over?
    winner || !@boards.include?(" ")  
  end



end

game = Game.new

