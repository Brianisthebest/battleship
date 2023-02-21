require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

game = Game.new

puts game.main_menu

puts game.comp_ship_placement