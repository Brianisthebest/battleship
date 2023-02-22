class Board

  attr_reader :cells, :valid_length, :valid_vertical
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
    @valid_submarine = [['A1', 'A2'], ['A2', 'A3'], ['A3', 'A4'], ['B1', 'B2'], ['B2', 'B3'], ['B3', 'B4'], ['C1', 'C2'], ['C2', 'C3'], ['C3', 'C4'], ['D1', 'D2'], ['D2', 'D3'], ['D3', 'D4'], ['A1', 'B1'], ['A2', 'B2'], ['A3', 'B3'], ['A4', 'B4'], ['B1', 'C1'], ['B2', 'C2'], ['B3', 'C3'], ['B4', 'C4'], ['C1', 'D1'], ['C2', 'D2'], ['C3', 'D3'], ['C4', 'D4']]

    @valid_cruiser = [['A1', 'A2', 'A3'], ['A2', 'A3', 'A4'], ['B1', 'B2', 'B3'], ['B2', 'B3', 'B4'], ['C1', 'C2', 'C3'], ['C2', 'C3', 'C4'], ['D1', 'D2', 'D3'], ['D2', 'D3', 'D4'], ['A1', 'B1', 'C1'], ['B1', 'C1', 'D1'], ['A2', 'B2', 'C2'], ['B2', 'C2', 'D2'], ['A3', 'B3', 'C3'], ['B3', 'C3', 'D3'], ['A4', 'B4', 'C4'], ['B4', 'C4', 'D4']]
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if valid_length?(ship, coordinates) && not_overlapping?(coordinates)
      valid_submarine(ship, coordinates) || valid_cruiser(ship, coordinates)
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) 
       coordinates.each do |coordinate|
         cell = @cells[coordinate] 
        cell.place_ship(ship) 
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
  
  def valid_submarine(ship, coordinates)
  @valid_submarine.select do |key|
    if key == coordinates
      return true
    end
  end
  false
  end
  
  def valid_cruiser(ship, coordinates)
  @valid_cruiser.select do |key|
    if key == coordinates
      return true
    end
  end
  false
end
end