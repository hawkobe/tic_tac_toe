require_relative '../lib/tic_tac_toe'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe TicTacToe do

  subject(:game) { described_class.new }
  let(:player1) { Player.new("Jacob", "X", 1) }
  let(:player2) { Player.new("Crystal", "Y", 2) }

  describe '#add_player' do

    it 'adds player to the instance variable array for players' do
      expect { game.add_player(player1) }.to change { game.instance_variable_get(:@players).length }.by(1)
    end
  end

  describe '#switch_player' do

    before do
      game.instance_variable_set(:@players, [player1, player2])
    end

    context 'when the current player is player 1' do

      before do
        game.instance_variable_set(:@current_player, player1)
      end

      it 'switches to player 2' do
        new_current = game.switch_player
        expect(new_current).to be(player2)
      end
    end

    context 'when the current player is player 2' do

      before do
        game.instance_variable_set(:@current_player, player2)
      end

      it 'switches to player 1' do
        new_current = game.switch_player
        expect(new_current).to be(player1)
      end
    end

    context 'when the current player has not been defined yet' do

      it 'switches to player 1' do
        new_current = game.switch_player
        expect(new_current).to be(player1)
      end
    end
  end

  describe '#game_won?' do

    context 'when there are three values in a row' do

      subject(:game_full_board) { described_class.new(Board.new(Array.new(9, 'X')), player1) }

      it 'the game is won' do
        expect(game_full_board).to be_game_won
        game_full_board.game_won?
      end
    end

    context 'when there are not three values in a row' do
      
      subject(:game_continues) { described_class.new(board_continues, player1) }
      let(:board_continues) { double(Board.new) }

      before do
        allow(board_continues).to receive(:board).and_return([1, 2, 3, 'X', 'Y', 'X', 7, 8, 9])
      end

      it 'the game continues' do
        expect(game_continues).to_not be_game_won
        game_continues.game_won?
      end
    end
  end

  describe '#check_win' do

    before do
      game.instance_variable_set(:@current_player, player1)
      allow(game).to receive(:win_message)
    end

    context 'when the game is not won' do

      before do
        allow(game).to receive(:game_won?).and_return(false)
      end

      it 'keeps the state of game over as false' do
        result = false
        expect(game.instance_variable_get(:@game_over)).to be(result)
        game.check_win
      end
    end

    context 'when the game is won' do

      before do 
        allow(game).to receive(:game_won?).and_return(true)
      end

      it 'changes the state of game over to true' do
        expect { game.check_win }.to change { game.instance_variable_get(:@game_over) }.to(true)
      end
    end
  end

  describe '#check_tie' do

    subject(:cats_game) { described_class.new(game_board) }
    let(:game_board) { instance_double(Board) }

    context 'when the board is full and game is not won' do

      before do
        allow(game_board).to receive(:board_full?).and_return(true)
        allow(cats_game).to receive(:game_won?).and_return(false)
        allow(game_board).to receive(:display_board)
        allow(cats_game).to receive(:tie_message)
      end

      it 'changes the state of game over to true' do
        expect { cats_game.check_tie }.to change { cats_game.instance_variable_get(:@game_over) }.to(true)
      end
    end

    context 'when the board is not full and the game is not won' do
      before do
        allow(game_board).to receive(:board_full?).and_return(false)
        allow(cats_game).to receive(:game_won?).and_return(false)
        allow(game_board).to receive(:display_board)
      end

      it 'keeps the state of game over as false' do
        expect(cats_game.instance_variable_get(:@game_over)).to be(false)
        cats_game.check_tie
      end

      it 'does not send game tie message' do
        expect(cats_game).to_not receive(:tie_message)
        cats_game.check_tie
      end
    end

    context 'when the board is full and game is won' do
    
      before do
        allow(game_board).to receive(:board_full?).and_return(true)
        allow(cats_game).to receive(:game_won?).and_return(true)
        allow(game_board).to receive(:display_board)
      end

      it 'does not execute tie message' do
        expect(cats_game).to_not receive(:tie_message)
        cats_game.check_tie
      end
    end
  end

  describe '#tie_message' do 

    subject(:tie_game) { described_class.new(game_board) }
    let(:game_board) { instance_double(Board) }

    before do
      allow(tie_game).to receive(:puts)
    end


    it 'sends display_board one time' do
      expect(game_board).to receive(:display_board)
      tie_game.tie_message
    end
  end

  describe '#play_again' do

    before do
      allow(game).to receive(:puts).with ('Would you like to play again? Type Y for yes or any other key to Exit:')
    end

    context 'when the user types something other than Y' do
      before do
        allow(game).to receive(:gets).and_return('no')
      end

      it 'triggers thank you message when the user types no' do
        expect(game).to receive(:thank_you_message).once
        game.play_again
      end

      before do
        allow(game).to receive(:gets).and_return('\n')
      end

      it 'triggers thank you message when the user presses enter' do
        expect(game).to receive(:thank_you_message).once
        game.play_again
      end
    end

    context 'when the user types exactly Y' do

      before do
        allow(game).to receive(:gets).and_return('Y')
      end

      it 'triggers new game' do
        expect(game).to receive(:new_game)
        game.play_again
      end
    end
  end

  describe '#symbol_valid?' do

    context 'when the player symbol is a single letter' do

      it 'returns true' do
        symbol = 'X'
        valid_symbol = true
        verified_result = symbol_valid?(symbol)
        expect(verified_result).to be(true)
      end
    end

    context 'when the player symbol is a symbol' do

      it 'returns true' do
        symbol = '!'
        verified_result = symbol_valid?(symbol)
        expect(verified_result).to be(true)
      end
    end

    context 'when the player symbol is more than one letter' do

      it 'returns false' do
        symbol = 'word'
        verified_result = symbol_valid?(symbol)
        expect(verified_result).to be(false)
      end
    end

    context 'when the player symbol is a number' do

      it 'returns false' do
        symbol = '2'
        verified_result = symbol_valid?(symbol)
        expect(verified_result).to be(false)
      end
    end
  end

  
  # describe '#symbol_available' do

  # end

  describe '#position_available?' do

    context 'when the player has selected an available position' do

      it 'returns true' do
        player_selection = 4
        board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        verified_result = position_available?(player_selection, board)
        expect(verified_result).to be(true)
      end
    end

    context 'when the player has selected an unavailable position' do 

      context 'when the player selects a position already taken' do

        it 'returns false' do
          player_selection = 4
          board = [1, 2, 3, 'X', 5, 6, 7, 8, 9]
          verified_result = position_available?(player_selection, board)
          expect(verified_result).to be(false)
        end
      end

      context 'when the player selects a position not on the board' do

        it 'returns false' do
          player_selection = 18
          board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
          verified_result = position_available?(player_selection, board)
          expect(verified_result).to be(false)
        end
      end
    end
  end
end
