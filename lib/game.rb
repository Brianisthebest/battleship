class Game
attr_reader :main_menu
  def initialize

  end

  def main_menu
    puts 'Welcome to BATTLESHIP
    Enter p to play. Enter q to quit.'

    input = gets.chomp

    if input == 'q'
      puts 'Thanks for playing, yall come back now.'
    elsif input == 'p'
      puts 'To your battle station!'
    else
      puts 'Invalid response.'
      self.main_menu
    end
  end
end