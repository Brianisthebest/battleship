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
      # self.player_ship_placement
      # self.comp_ship_placement
    else
      puts 'Invalid response.'
      self.main_menu
    end
  end

  def comp_ship_placement
    cruiser = Ship.new('Cruiser', 3)
      random_placement = @comp_board.cells.keys.sample(3)
      #  if @comp_board.valid_coordinate?(random_placement)
        #  @comp_board.place(cruiser, ['A1', 'A2', 'A3']) ##we just set computer placement coordinates. figure out randomize later
  end

  def player_ship_placement
    cruiser = Ship.new('Cruiser', 3)

    puts "It's time to put out your ships."
    puts "The cruiser is 3 units long, the submarine is 2 units long"
    puts "***********************************"
    puts @player_board.render
    puts "Enter the squares for cruiser (3 spaces):"
    coordinates = gets.chomp.split
    if @player_board.valid_placement?(cruiser, coordinates)
      @player_board.place(cruiser, coordinates)
      puts "***********************************"
      puts @player_board.render(true)
    else
      puts 'Invalid response.'
      self.player_ship_placement
    end
     self.player_submarine
  end
  
  #helper method
  def player_submarine
    submarine = Ship.new('Submarine', 2)
    puts 'Enter the squares for submarine (2 spaces):'
    coordinates = gets.chomp.split
    if @player_board.valid_placement?(submarine, coordinates)
     @player_board.place(submarine, coordinates)
     puts "***********************************"
     puts @player_board.render(true)
    else
     puts 'Invalid response.'
     self.player_submarine
    end
  end
end