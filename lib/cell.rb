class Cell
    attr_reader :coordinate, :ship
    
    def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    end

    def empty?
      if @ship == nil
        true
      else
        false
      end
    end

    def place_ship(placed_ship)
      @ship = placed_ship
    end

    def fired_upon?
      if @ship.health < @ship.length
        true
      else
        false
      end
    end

    def fire_upon
      @ship.hit
    end
end

