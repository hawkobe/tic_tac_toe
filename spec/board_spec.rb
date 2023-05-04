require_relative '../lib/board'
require_relative '../lib/tic_tac_toe'

describe Board do

  describe "#board_full?" do

    context 'when the board is full' do
      subject(:board) { described_class.new(Array.new(9, 'x')) }
      it 'returns true' do
        expect(board.board_full?).to eq(true)
      end
    end

    context 'when the board is not full' do
      subject(:board) { described_class.new }
      it 'returns false' do
        expect(board.board_full?).to eq(false)
      end
    end

    context 'when the board is one away from full' do
      subject(:board) { described_class.new(Array.new(9, 'x')) }
      it 'returns false' do
        my_board = board.instance_variable_get(:@board)
        my_board[1] = 1
        verified_result = board.board_full?
        expect(verified_result).to eq(false)
      end
    end
  end
end
    