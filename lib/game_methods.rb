module GameMethods
  
  def symbol_valid?(symbol)
    symbol.length == 1 && symbol.match?(/[^0-9]/)
  end

  def symbol_available?(symbol, class_name)
    class_name.all.none? { |player| player.symbol == symbol }
  end

  def position_available?(selection, board)
    board[selection - 1].is_a?(Numeric) && selection.between?(1, 9)
  end

  def execute_move(selection, board, player_symbol)
    board[selection - 1] = player_symbol
  end
  
  def place_marker(board, player_symbol)
    puts "#{self.name}, it's your move. Please select an available position:"
    selected_position = gets.chomp.to_i
    until position_available?(selected_position, board)
      puts "Position not unavailable, please select a new position"
      selected_position = gets.chomp.to_i
    end
    execute_move(selected_position, board, player_symbol)
  end

end
