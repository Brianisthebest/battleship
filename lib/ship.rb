class Ship
attr_reader :name, :length, :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
  end

  def sunk?
    if @health == 0
      true
    else
      false
    end
  end

  def hit
    @health -= 1
  end
end