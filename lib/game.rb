require_relative 'tic_tac_toe'

class Game
  def initialize(game)
    @game = game.new
  end

  def play
    @game.play
  end
end