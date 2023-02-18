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
      expect(@board.cells.keys.count).to eq(16)
      expect(@board.cells.values).to be_a(Array)
      expect(@board.cells.values.count).to eq(16)
      expect(@board.cells.values.first).to be_a(Cell)
    end

  describe '#valid_coordinate?' do
    it 'can determine if a coordinate is valid or not' do
      expect(@board.valid_coordinate?('A1')).to eq(true)
      expect(@board.valid_coordinate?('D4')).to eq(true)
      expect(@board.valid_coordinate?('A5')).to eq(false)
      expect(@board.valid_coordinate?('E1')).to eq(false)
      expect(@board.valid_coordinate?('A22')).to eq(false)
    end

  
  end


  end
end