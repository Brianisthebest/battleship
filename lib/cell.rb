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
end

