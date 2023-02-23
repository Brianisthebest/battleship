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
    welcome_render
    comp_cruiser_placement
    comp_sub_placement
    player_ship_placement
    sleep(2)
    display_boards
    sleep(2)
    game_over
    sleep(2)
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
    puts "**********************************************************"
    puts "It's time to put out your ships."
    puts "**********************************************************"
    puts "The cruiser is 3 units long, the submarine is 2 units long"
    puts "**********************************************************"
    puts @player_board.render
    puts "Enter the squares for cruiser (3 spaces):"
    coordinates = gets.chomp.upcase.split
    if @player_board.valid_placement?(cruiser, coordinates)
      @player_board.place(cruiser, coordinates)
      puts "********************************************************"
      puts @player_board.render(true)
    else
      puts 'Invalid response.'
      player_ship_placement
    end
    player_submarine
    puts "********************************************************"
  end

  def display_boards
    puts "***********Computer Board*********************************"
    puts @comp_board.render
    puts "***********Player Board***********************************"
    puts @player_board.render(true)
  end

  def player_turn
    puts "Choose a valid coordinate to fire upon"
    puts "=========================================================="
    coordinate = gets.chomp.upcase
    if @comp_board.valid_coordinate?(coordinate) && !@comp_board.cells[coordinate].fired_upon?
      @comp_board.cells[coordinate].fire_upon 
      hit_miss_sink_player(coordinate)
    else
      puts "Already guessed"
      player_turn
    end
  end

  def comp_turn
    comp_guess = @player_board.cells.keys.sample(1)
    if !@player_board.cells[comp_guess.join].fired_upon?
      @player_board.cells[comp_guess[0]].fire_upon
      puts "--------------------------------------------------------"
      puts "I fire upon #{comp_guess[0]}"
      comp_hit_miss_sink(comp_guess)
    else
      comp_turn
    end
  end

  def game_over
    until (@player_cruiser_sunk == true && @player_sub_sunk == true) || (@comp_cruiser_sunk == true && @comp_sub_sunk == true)
      player_turn
      sleep(3)
      display_boards
      comp_turn
      display_boards
      ship_sunk
    end
    game_over_man
  end

  #helper method
  def game_over_man
    if @player_cruiser_sunk == true && @player_sub_sunk == true
      puts 'Game Over'
      puts 'Computer wins'
      game_reset
    elsif @comp_cruiser_sunk == true && @comp_sub_sunk == true
      puts 'Game Over'
      puts "############################################################"
      puts " 
      ___  ____            _           ____     _    _  
      |   |/   /           | |         /    \    (_)   | | 
      |   '   /  ___   ___ | |  ___   /   _  \    _  __| | 
      |      <  / _ \ / _ \| | |___|  /   (_)  \  | |/ _` | 
      |   .   \ | (_) | (_) | |        /   ____   \ | | (_) | 
      |___|\___\\___/ \___/|_|     /___/    \___\|_|\__,_| 
      _______________          ____________            
      ( _____________ ) ___    (  YOU WIN   )           
      /    _     _    \/ _ \   (  OH YEAH!  )           
      /    (,)   (,)    \/ \ \ /_____________)           
      |         _         | | |               _______     
      |        (_)        | | |   _______    (  . .  )_   
      |     .       .     |/ /   (  . .  )_  |   o   |_)  
      \     '.....'     /__/    |   o   |_)  ) '-' (     
        \               /         ) '-' (    (_______)    
        )_____________(         (_______)                
        ____(_______________)_________________________________
        ______            __    __    __                   
        / __/ /  ___ _____/ /__ / /__ / /  ___ __________ __
        _\ \/ _ \/ _ `/ __/  '_// / -_) _ \/ -_) __/ __/ // /
        /___/_//_/\_,_/_/ /_/\_\/_/\__/_.__/\__/_/ /_/  \_, / 
        ___ _                 /___/  
        / __(_)__                    
        / _// / _ \                  
        ____      /_/ /_/_//_/        __          
        / __/__  _______ _  _____ ____/ /          
        / _// _ \/ __/ -_) |/ / -_) __/_/           
        /_/  \___/_/  \__/|___/\__/_/ (_)"
        
      puts '##########################################################################'
      puts 'You Win!!!!!!'
      sleep(3)
      game_reset
    else @player_cruiser_sunk == true && @player_sub_sunk == true && @comp_cruiser_sunk == true && @comp_sub_sunk == true
      puts "Everyone loses!"
      game_reset
    end
  end
  
  def player_submarine
    submarine = Ship.new('Submarine', 2)
    puts 'Enter the squares for submarine (2 spaces):'
    coordinates = gets.chomp.upcase.split
    if @player_board.valid_placement?(submarine, coordinates)
      @player_board.place(submarine, coordinates)
      puts "**************************************************"
      puts @player_board.render(true)
    else
      puts 'Invalid response.'
      player_submarine
    end
  end
  
  def ship_sunk
    it_sunk
  end
  
  def game_reset
    @comp_cruiser_sunk = nil
    @comp_sub_sunk = nil
    @player_cruiser_sunk = nil
    @player_sub_sunk = nil
    @player_board = Board.new
    @comp_board  = Board.new
    main_menu
  end
  
  def hit_miss_sink_player(coordinate)
    if @comp_board.cells[coordinate].ship != nil
      if @comp_board.cells[coordinate].ship.sunk? == true
        puts 'you sunk my battleship!'
        puts "
        
        _______
        /         \\
        /             \\
        /                 \\
        /           _________\\
        /        __/;|_[_]|_\\__
        /        /  |;'_|_] [] _|  
        /         |__|__]'|_|_/.\_\\
        /             |===========|
        /        |_____/UUUUUUUUUUUU\\
        /         \\_~~~~~~~~\\\\__   __/
        |:::::::::::|\\\\~~\\\\
        |:::::::::::|~\\\\~~\\\\
        /~~~~~~~~~~~\\\\__\\\\_\\\\
        /               UUUUUU
        
        The ship is sinking!"
        
      elsif @comp_board.cells[coordinate].shot == true
        puts "you hit evil computer's battleship on #{coordinate}!"
      end
    end
    if @comp_board.cells[coordinate].ship == nil
      @comp_board.cells[coordinate].miss == true
      puts "--------------------------------------------------------------"
      puts "Nooo! you missed evil computer's battleship on #{coordinate}!"
    end
  end
  
  def comp_hit_miss_sink(comp_guess)
    if @player_board.cells[comp_guess[0]].ship != nil
      if @player_board.cells[comp_guess[0]].ship.sunk? == true
        puts 'I sunk your battleship!'
        sleep(2)
      elsif @player_board.cells[comp_guess[0]].shot == true
        puts "I hit your battleship on #{comp_guess[0]}!"
        sleep(2)
      end
    end
    if @player_board.cells[comp_guess[0]].ship == nil
      @player_board.cells[comp_guess[0]].miss == true
      puts "Nooo! I missed your battleship on #{comp_guess[0]}!"
      sleep(2)
    end
  end
  
  def it_sunk
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
  def welcome_render
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
      puts '      
        1   2   3   4   
      +---+---+---+---+
    A |   |   |   |   |  
      +---+---+---+---+
    B |   |   |   |   | 
      +---+---+---+---+
    C |   |   |   |   |  
      +---+---+---+---+
    D |   |   |   |   |
      +---+---+---+---+'
    else
      puts 'Invalid response.'
      main_menu
    end
  end
end