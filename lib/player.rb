require_relative '../lib/game_methods.rb'
include GameMethods

class Player
  attr_reader :name, :symbol, :player_number
  @@all = []

  private
  
  def initialize(name, symbol, player_number)
    @name = name
    @symbol = symbol
    @player_number = player_number
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_player
    puts "Name: "
    name = gets.chomp
    puts "Please enter a non-number symbol to identify you: "
    symbol = gets.chomp
    until symbol_valid?(symbol) && symbol_available?(symbol, self)
      puts "Invalid input, please enter a valid symbol:"
      symbol = gets.chomp
    end
    player_number = self.all.length + 1
    Player.new(name, symbol, player_number)
  end

  def self.clear_players
    @@all = []
  end

end
