class Board

  attr_reader :cells, :valid_horizontal_cruiser, :valid_vertical_cruiser, :valid_horizontal_submarine, :valid_vertical_submarine, :valid_vertical_submarine 
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
    @valid_horizontal_cruiser = [['A1', 'A2', 'A3'], ['A2', 'A3', 'A4'], ['B1', 'B2', 'B3'],['B2', 'B3', 'B4'],['C1', 'C2', 'C3'], ['C2', 'C3', 'C4'], ['D1', 'D2', 'D3',], ['D2', 'D3', 'D4']]
    @valid_vertical_cruiser = [['A1', 'B1', 'C1'], ['B1', 'C1', 'D1'], ['A2', 'B2', 'C2'],['B2', 'C2', 'D2'],['A3', 'B3', 'C3'], ['B3', 'C3', 'D3'], ['A4', 'B4', 'C4'], ['B4', 'C4', 'D4']]
    @valid_horizontal_submarine = [['A1', 'A2'], ['A2', 'A3'], ['A3', 'A4'], ['B1', 'B2'], ['B2', 'B3'], ['B3', 'B4'], ['C1', 'C2'], ['C2', 'C3'], ['C3', 'C4'], ['D1', 'D2'], ['D2', 'D3'], ['D3', 'D4']] 
    @valid_vertical_submarine = [['A1', 'B1'], ['B1', 'C1'], ['C1', 'D1'], ['A2', 'B2'], ['B2', 'C2'], ['C2', 'D2'], ['A3', 'B3'], ['B3', 'C3'], ['C3', 'D3'], ['A4', 'B4'], ['B4', 'C4'], ['C4', 'D4']] 
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if valid_length?(ship, coordinates) && not_overlapping?(coordinates)
      valid_coordinates(ship, coordinates)
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) #moved this up, if valid_placement?(ship, coordinates) then allow rest of method to run
       coordinates.each do |coordinate|#each method is being called on the coordinates array(from cell class)
        if valid_coordinate?(coordinate) #Added to check coordinate sent in is valid before placing.
          cell = @cells[coordinate] #creating local variable for the cell object(@cells[coordinate])
          cell.place_ship(ship) #call place_ship method(from cell class) on variable we created for cell object, pass in ship argument
        end
      end
    end
  end
  
def render(access = false)
  if access == true
    "  1 2 3 4 \nA #{@cells['A1'].render(true)} #{@cells['A2'].render(true)} #{@cells['A3'].render(true)} #{@cells['A4'].render(true)} \n" +
    "B #{@cells['B1'].render(true)} #{@cells['B2'].render(true)} #{@cells['B3'].render(true)} #{@cells['B4'].render(true)} \n" +
    "C #{@cells['C1'].render(true)} #{@cells['C2'].render(true)} #{@cells['C3'].render(true)} #{@cells['C4'].render(true)} \n" +
    "D #{@cells['D1'].render(true)} #{@cells['D2'].render(true)} #{@cells['D3'].render(true)} #{@cells['D4'].render(true)} \n"
  else
    "  1 2 3 4 \nA #{@cells['A1'].render} #{@cells['A2'].render} #{@cells['A3'].render} #{@cells['A4'].render} \n" +
    "B #{@cells['B1'].render} #{@cells['B2'].render} #{@cells['B3'].render} #{@cells['B4'].render} \n" +
    "C #{@cells['C1'].render} #{@cells['C2'].render} #{@cells['C3'].render} #{@cells['C4'].render} \n" +
    "D #{@cells['D1'].render} #{@cells['D2'].render} #{@cells['D3'].render} #{@cells['D4'].render} \n"
  end
end

  #Helper Method
  
  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def not_overlapping?(coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end
  end

  def valid_coordinates(ship, coordinates)
    if ship.name == 'Cruiser'
      @valid_horizontal_cruiser.include?(coordinates) || @valid_vertical_cruiser.include?(coordinates)
    elsif ship.name == 'Submarine'
      @valid_horizontal_submarine.include?(coordinates) || @valid_vertical_submarine.include?(coordinates)
    end
  end
end