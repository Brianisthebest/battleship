require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new('B4')
    @cell_1 = Cell.new('B4')
    @cell_2 = Cell.new('C3')
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq('B4')
    end
  end

  describe '#place_ship' do
    it 'starts off nil' do
      expect(@cell.ship).to eq(nil)
    end

    it 'can check the cell to see if its empty' do
      expect(@cell.empty?).to eq(true)
    end

    it 'can place a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to be_a(Ship)
      expect(@cell.empty?).to eq(false)
    end

    it 'can be fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end

    it ' can miss' do
      @cell.fire_upon
      expect(@cell.miss).to eq(true)
    end
  end

  describe '#render' do
    it 'can render the cell' do
      expect(@cell_1.render).to eq('.')
    end
      
    it 'can render a miss' do
      @cell_1.fire_upon
      expect(@cell_1.render).to eq('M')
    end 

    it 'can render a ship in a cell' do
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq('.')
      expect(@cell_2.render(true)).to eq('S')
    end

    it 'can render a hit' do
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      expect(@cell_2.render).to eq('H')
    end

    it 'checks if a cruiser has sunk and renders x' do
      @cell_2.place_ship(@cruiser)
      expect(@cruiser.sunk?).to eq(false)
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq('X')
    end
  end
end