require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end
  
  describe '#initialize' do
    it 'exits' do
      expect(@game).to be_a(Game)
    end

    it 'has a main menu' do
      @game.player_turn
      # @game.comp_ship_placement
      @game.game_over
    end
  end

  describe '#comp_turn' do
    it 'takes a turn' do
      # expect
    end
  end
end
