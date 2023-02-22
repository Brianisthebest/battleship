class Cell
    attr_reader :coordinate, :ship, :miss, :shot
    
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @miss = false
    @shot = false
  end

  def empty?
   @ship.nil?
    
  end

  def place_ship(placed_ship)
    if empty?
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
    if empty? 
      fire_upon_empty
    else !empty?
      fire_upon_filled
    end
  end
  
  def render(hidden_access = false)
    if !fired_upon? && !empty? && hidden_access == true
      'S'
    elsif empty?
      render_empty_cells
    elsif !empty?
      render_filled_cells
    end
  end
  
  #Helper Methods
  
  def render_empty_cells
    if fired_upon?
      'M'
    else
      '.'
    end
  end
  
  def render_filled_cells
    if @ship.sunk?
      'X'
    elsif fired_upon? && @shot == true
      'H'
    else
      '.'
    end
  end

  def fire_upon_empty
    if @shot == false 
        @miss = true
    end
  end

  def fire_upon_filled
    if @shot == true
    else @shot == false
      @ship.hit
      @shot = true
    end
  end
end