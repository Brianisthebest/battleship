class Ship
attr_reader :name, :length, :health, :sunk
  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
  end
end