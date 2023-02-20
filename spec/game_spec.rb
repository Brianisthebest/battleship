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
      expect(@game.main_menu).to 
    end
  end
end
