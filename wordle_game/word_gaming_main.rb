# main.rb

require_relative 'game_flow_controller'
require_relative 'guessing_logic_handler'
require_relative 'internet_connection_monitor'
require_relative 'word_validator'
require_relative 'game_feedback'

class Wordle
  include GameFlowController
  include GuessingLogicHandler
  include InternetConnectionMonitor
  include WordValidator
  include GameFeedback
  def initialize
    @@letter_statuses = ("A".."Z").to_a
  end
end

# Create and start the game
game = Wordle.new
game.display_game_menu
