require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
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

  describe '#valid_placement?' do
    it 'checks if the placement is valid or not' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['A2', 'A3', 'A4'])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ['A2', 'A3', 'A4'])).to eq(true)
      expect(@board.valid_placement?(@submarine, ['A1', 'A2'])).to eq(true)
    end

    xit 'makes sure coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['A1', 'C1'])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ['A3', 'A2', 'A1'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['C1', 'B1'])).to eq(false)
    end
  end
end