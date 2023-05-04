require_relative '../lib/board'
require_relative '../lib/tic_tac_toe'

describe Board do

  describe "#board_full?" do

    context 'when the board is full' do
      subject(:full_board) { described_class.new(Array.new(9, 'x')) }
      it 'returns true' do
        expect(full_board).to be_board_full
      end
    end

    context 'when the board is not full' do
      subject(:empty_board) { described_class.new }
      it 'returns false' do
        expect(empty_board).to_not be_board_full
      end
    end

    context 'when the board is one away from full' do
      subject(:partial_board) { described_class.new(Array.new(9, 'x')) }
      it 'returns false' do
        my_board = partial_board.instance_variable_get(:@board)
        my_board[1] = 1
        verified_result = partial_board.board_full?
        expect(verified_result).to eq(false)
      end
    end
  end
end
    