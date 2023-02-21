class Game
attr_reader :main_menu
  def initialize
    @player_board = Board.new
    @comp_board  = Board.new
  end

  def main_menu
    puts 'Welcome to BATTLESHIP
    Enter p to play. Enter q to quit.'

    input = gets.chomp

    if input == 'q'
      puts 'Thanks for playing, yall come back now.'
    elsif input == 'p'
      puts 'To your battle station!'
      comp_ship_placement
    else
      puts 'Invalid response.'
      self.main_menu
    end
  end

  def comp_ship_placement
    cruiser = Ship.new('Cruiser', 3)
    rand_coords = @valid_vertical
    @comp_board.place(cruiser, rand_coords.sample(3)) 
      # @comp_board.cells.keys.sample(3)
  end
end