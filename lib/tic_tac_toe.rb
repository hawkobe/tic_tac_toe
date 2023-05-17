require_relative 'board'
require_relative 'player'
require_relative 'game_methods'
include GameMethods

class TicTacToe
  # include GameMethods
  def play
    setup
    game_loop
    Player.clear_players
    play_again
  end

  attr_reader :board, :players, :current_player
  WINNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize(board = Board.new, current_player = nil)
    @board = board
    @players = []
    @current_player = current_player
    @game_over = false
  end

  def add_player(player)
    @players << player
  end

  def setup
    puts "Welcome to Tic Tac Toe!"
    puts "Player 1 enter your information"
    add_player(Player.create_player)
    puts "Player 2 enter your information"
    add_player(Player.create_player)
    @current_player = self.players[1]
  end

  def switch_player
    @current_player == @players[0] ? @current_player = @players[1] : @current_player = @players[0]
  end

  def game_loop
    until @game_over
      board.display_board
      switch_player
      self.current_player.place_marker(board.board, @current_player.symbol)
      check_win
      check_tie
    end
  end 

  def game_won?
    WINNING_COMBOS.any? do |combo|
      board.board.values_at(combo[0], combo[1], combo[2]).all?(self.current_player.symbol)
    end
  end

  def check_win
    if game_won?
      @game_over = true
      win_message
    end
  end

  def check_tie
    if board.board_full? && !game_won?
      @game_over = true
      tie_message
    end
  end

  def tie_message
    board.display_board
    puts "Cat's game! No one is a winner. Better luck next time."
  end

  def win_message
    board.display_board
    puts "Congratulations, #{@current_player.name}. You've won!"
  end

  def thank_you_message
    puts "Thanks for playing! See you next time."
  end

  def play_again
    puts "Would you like to play again? Type Y for yes or any other key to Exit:"
    user_response = gets.chomp
    user_response == "Y" ? new_game : thank_you_message
  end

  def new_game
    TicTacToe.new.play
  end

end