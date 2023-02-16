require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new('B4')
    @cruiser = Ship.new('Cruiser', 3)
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
  end
end