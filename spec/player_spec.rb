require_relative '../lib/player.rb'
require_relative '../lib/game_methods.rb'

describe Player do

  describe '#create_player' do

    context 'when symbol is valid and available' do
      before do
        allow(GameMethods).to receive(:symbol_available?).and_return(true)
        allow(GameMethods).to receive(:symbol_valid?).and_return(true)
        allow(Player).to receive(:gets).and_return("Jacob", "x")
        allow(Player).to receive(:puts)
      end

      it 'starts a new instance of player' do
        expect(Player).to receive(:new).once
        Player.create_player
      end

      it 'adds player to all players array' do
        Player.create_player
        expect(Player.all.length).to be(1)
      end
    end
  end

  describe '#clear_players' do

    before do
      Player.all << Player.new("Jacob", "X", 1)
    end

    it 'removes any current players' do
      Player.clear_players
      expect(Player.all.length).to be(0)
    end
  end

  describe '#symbol_available' do

    before do
      Player.new('Jacob', 'X', 1)
    end

    context 'when the symbol is available' do

      it 'returns true' do
        verified_result = Player.symbol_available?('y', Player)
        expect(verified_result).to be(true)
      end
    end

    context 'when the symbol is unavailable' do

      it 'returns false' do
        verified_result = Player.symbol_available?('X', Player)
        expect(verified_result).to be(false)
      end
    end
  end
end
