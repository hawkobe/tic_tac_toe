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

    context 'when the current player is player 1' do

      it 'switches to player 2' do
        players = [player1, player2]
        current_player = player1
        new_current = game.switch_player(current_player, players)
        expect(new_current).to be(player2)
      end
    end

    context 'when the current player is player 2' do

      it 'switches to player 1' do
        players = [player1, player2]
        current_player = player2
        new_current = game.switch_player(current_player, players)
        expect(new_current).to be(player1)
      end
    end

    context 'when the current player has not been defined yet' do

      it 'switches to player 1' do
        players = [player1, player2]
        current_player = nil
        new_current = game.switch_player(current_player, players)
        expect(new_current).to be(player1)
      end
    end
  end
end
