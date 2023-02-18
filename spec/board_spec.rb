require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe '#initialize' do
    it 'exits' do
      expect(@board).to be_a(Board)
    end

    it 'is a hash of cells' do
      expect(@board.cells).to be_a(Hash)
    end
  end
end