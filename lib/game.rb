class Game
  attr_reader :main_menu
  def initialize
    @player_board = Board.new
    @comp_board  = Board.new
    @player_cruiser_sunk = nil
    @player_sub_sunk = nil
    @comp_cruiser_sunk = nil
    @comp_sub_sunk = nil
  end

  



  
  def main_menu
    puts '                               Welcome to BATTLESHIP

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~oo~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                 o o
                                 o ooo
                                   o oo
                                      o o      |   #)
                                       oo     _|_|_#_ 
                                         o   | 751   |
    __                    ___________________|       |_________________
   |   -_______-----------                                              \
  >|    _____                                                   --->     )
   |__ -     ---------_________________________________________________ /

                        Enter p to play. Enter q to quit.'
    input = gets.chomp

    if input == 'q'
      puts 'Thanks for playing, yall come back now.'
      exit
    elsif input == 'p'
      puts 'To your battle station!'
    else
      puts 'Invalid response.'
      main_menu
    end
  end

  def comp_cruiser_placement
    cruiser = Ship.new('Cruiser', 3)
    coordinates = @comp_board.cells.keys.each_cons(3).to_a.sample 
    if @comp_board.valid_placement?(cruiser, coordinates)
        @comp_board.place(cruiser, coordinates)
        puts "I've placed my cruiser"
      else
        comp_cruiser_placement
    end
  end

  def comp_sub_placement
    submarine = Ship.new('Submarine', 2)
    coordinates = @comp_board.cells.keys.each_cons(2).to_a.sample
    if @comp_board.valid_placement?(submarine, coordinates)
      @comp_board.place(submarine, coordinates)
      puts "I've placed my submarine, now your turn loser"
    else
      comp_sub_placement
    end
  end

  def player_ship_placement
    cruiser = Ship.new('Cruiser', 3)

    puts "It's time to put out your ships."
    puts "The cruiser is 3 units long, the submarine is 2 units long"
    puts "*************************************"
    puts @player_board.render
    puts "Enter the squares for cruiser (3 spaces):"
    coordinates = gets.chomp.split
    if @player_board.valid_placement?(cruiser, coordinates)
      @player_board.place(cruiser, coordinates)
      puts "***********************************"
      puts @player_board.render(true)
    else
      puts 'Invalid response.'
      player_ship_placement
    end
      player_submarine
      puts "***********************************"
  end

  def display_boards
    puts "***********Computer Board*************************"
    puts @comp_board.render(true)
    puts "***********Player Board*************************"
    puts @player_board.render(true)
  end

  def player_turn
    puts "Choose a valid coordinate to fire upon"
    coordinate = gets.chomp
    if @comp_board.valid_coordinate?(coordinate) && !@comp_board.cells[coordinate].fired_upon?
      @comp_board.cells[coordinate].fire_upon 
    else
      puts "Already guessed"
      player_turn
    end
  end

  def comp_turn
    comp_guess = @player_board.cells.keys.sample(1)
    # if @player_board.valid_coordinate?(comp_guess) && !@player_board.cells[comp_guess].fired_upon?
      @player_board.cells[comp_guess[0]].fire_upon
      puts "I fire upon #{comp_guess[0]}"
    # else
    #   comp_turn
    # end
    ## Why is this not working as intended?
  end

  def game_over
      until (@player_cruiser_sunk == true && @player_sub_sunk == true) || (@comp_cruiser_sunk == true && @comp_sub_sunk == true)
        player_turn 
        display_boards
        comp_turn
        display_boards
        ship_sunk
    end
    if @player_cruiser_sunk == true && @player_sub_sunk == true
      puts 'Game Over'
      puts 'Computer wins'
    elsif @comp_cruiser_sunk == true && @comp_sub_sunk == true
      puts 'Game Over'
      puts 'You Win'
    end
    main_menu
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
     player_submarine
    end
  end

  def ship_sunk
    @player_board.cells.each do |_, cell|
      if cell.ship != nil
        if cell.ship.name == 'Cruiser' && cell.ship.sunk? == true
          @player_cruiser_sunk = true
        elsif cell.ship.name == 'Submarine' && cell.ship.sunk? == true
          @player_sub_sunk = true
        end
      end
    end
    @comp_board.cells.each do |_, cell|
      if cell.ship != nil
        if cell.ship.name == 'Cruiser' && cell.ship.sunk? == true
          @comp_cruiser_sunk = true
        elsif cell.ship.name == 'Submarine' && cell.ship.sunk? == true
          @comp_sub_sunk = true
        end
      end
    end
  end
end