class Board

  attr_reader :cells, :valid_length
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
    @valid_vertical = ['A1', 'B1', 'C1', 'D1', 'A2', 'B2', 'C2', 'D2', 'A3', 'B3', 'C3', 'D3', 'A4', 'B4', 'C4', 'D4']
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if valid_length?(ship, coordinates)
      consecutive_coordinates(ship, coordinates) || valid_verticals(ship, coordinates)
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) #moved this up, if valid_placement?(ship, coordinates) then allow rest of method to run
       coordinates.each do |coordinate|#each method is being called on the coordinates array(from cell class)
         @cell = @cells[coordinate] #creating local variable for the cell object(@cells[coordinate])
        @cell.place_ship(ship) #call place_ship method(from cell class) on variable we created for cell object, pass in ship argument
      end
    end
  end

   
    # if coordinates.each { |coordinate| valid_coordinate?(coordinate) && valid_placement?(ship, coordinate) } then return true
    #   @cells.each do |coordinate|

  
  #Helper Method
  
  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end
  
  def consecutive_coordinates(ship, coordinates)
    @cells.keys.each_cons(ship.length) do |key|
      if key == coordinates
        return true
      end
    end
    false
  end

  def valid_verticals(ship, coordinates)
    @valid_vertical.each_cons(ship.length) do |key|
      if key == coordinates
        return true
      end
    end
    false
  end
end