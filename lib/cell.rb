class Cell
    attr_reader :coordinate, :ship
    
    def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    end

    def empty?
      true
    end

    def place_ship(placed_ship)
      @ship = placed_ship
    end
end

