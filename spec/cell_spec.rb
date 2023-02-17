require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new('B4')
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
      expect(@cell.place_ship(@submarine)).to eq('Ship already placed.')
    end

    it 'can be fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.fire_upon).to eq('Already guessed.')
    end

    it ' can miss' do
      @cell.fire_upon
      expect(@cell.miss).to eq(true)
    end
  end
end