class Cell
    attr_reader :coordinate, :ship, :miss, :shot
    
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @miss = false
    @shot = false
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
    if @shot == true || @miss == true
      true
    else
      false
    end
  end

  def fire_upon
    if @ship == nil && @shot == false
      @miss = true
    elsif @ship == nil && @shot == true
      'Already guessed.'
    elsif @ship == ship && @shot == true
      'Already guessed.'
    elsif @ship == ship && @shot == false
        @ship.hit
        @shot = true
    end
  end
end

