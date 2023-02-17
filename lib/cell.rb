class Cell
    attr_reader :coordinate, :ship, :miss, :hit
    
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @miss = false
    @hit = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(placed_ship)
    if @ship == nil
      @ship = placed_ship
    else
      'Ship already placed.'
    end
  end

  def fired_upon?
    if @hit == true || @miss == true
      true
    else
      false
    end
  end

  def fire_upon
    if @ship == ship && @hit == false
      @ship.hit
      @hit = true
    elsif @ship == ship && hit == true
      'Already guessed.'
    else
      @miss = true
    end
  end
end

