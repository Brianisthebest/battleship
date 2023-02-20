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
    it 'checks if the length is valid or not' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['A2', 'A3', 'A4'])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ['A2', 'A3', 'A4'])).to eq(true)
      expect(@board.valid_placement?(@submarine, ['A1', 'A2'])).to eq(true)
    end

    it 'makes sure coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['A1', 'C1'])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ['A3', 'A2', 'A1'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['C1', 'B1'])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ['B1', 'B2', 'B3'])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ['A1', 'B1', 'C1'])).to eq(true)
    end

    it 'makes sure coordinates cant be diagonal' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'B1', 'C3'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['C2', 'D3'])).to eq(false)
      expect(@board.valid_placement?(@submarine, ['A1', 'A2'])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ['B1', 'C1', 'D1'])).to eq(true)
    end
  end

  describe '#place' do
    it 'can place a ship on the board' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      @cell_1 = @board.cells["A1"]
      @cell_2 = @board.cells["A2"]
      @cell_3 = @board.cells["A3"]
      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_2.ship).to eq(@cruiser)
      expect(@cell_3.ship).to eq(@cruiser)
      # require 'pry'; binding.pry   ## hitting a pry @board.cells here i can now see the ship in cells above. need to reach through the cells object to test that both cells have same ship object
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
      expect(@board.cells["A4"].ship).to eq(nil)
      expect(@cell_3.ship).to eq(@cell_2.ship)
    end
    
    it 'places another ship on the board' do
      @board.place(@submarine, ['B1', 'C1'])
      @cell_1 = @board.cells["B1"]
      @cell_2 = @board.cells["C1"]
      expect(@cell_1.ship).to eq(@submarine)
      expect(@cell_2.ship).to eq(@submarine)
      expect(@board.cells["B1"].ship).to eq(@submarine)
      expect(@board.cells["C1"].ship).to eq(@submarine)
      expect(@board.cells["A1"].ship).to eq(nil)
      expect(@cell_1.ship).to eq(@cell_2.ship)
    end

    it 'doesnt allow ships to overlap' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])

      expect(@board.valid_placement?(@submarine, ['A1', 'A2'])).to eq(false)
    end
  end

  describe '#render' do
    it 'can render the board' do
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can check for player ships, hits, and misses' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])

      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    end
  end
end