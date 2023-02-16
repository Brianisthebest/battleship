require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
  end
  it 'exists' do
    expect(@cruiser).to be_a_kind_of(Ship)
  end

  it 'has a name' do
    expect(@cruiser.name).to eq('Cruiser')
  end
  it 'the length of the ship is 3' do
    expect(@cruiser.length).to eq(3)
  end

  it 'its health is 3' do
    expect(@cruiser.health).to eq(3)
  end

  it 'checks if it is sunk?' do
    expect(@cruiser.sunk?).to eq(false)
  end

  it 'can gets hit and loses one health and checks if it sunk' do
    @cruiser.hit

    expect(@cruiser.health).to eq(2)
    @cruiser.hit

    expect(@cruiser.health).to eq(1)
    expect(@cruiser.sunk?).to eq(false)
    @cruiser.hit

    expect(@cruiser.health).to eq(0)
    expect(@cruiser.sunk?).to eq(true)
  end
end