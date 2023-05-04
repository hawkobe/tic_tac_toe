class Board

  attr_reader :board
  def initialize(board = (1..9).to_a)
    @board = board
  end

  def display_board
    puts "Here's what your board looks like:"
    puts
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts " --+---+-- "
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts " --+---+-- "
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} " 
    puts
  end

  def board_full?
    @board.none?(Numeric)
  end
end

# v trying to work on scalabilty v

# puts
# board.each do |num|
#   num % (board.length**0.5) == 0 ? print("#{board[num - 1]}") : print("#{board[num - 1]} | ")
#   print "\n" if num % (board.length**0.5) == 0
# end
# puts
