require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

game = Game.new

puts game.main_menu

puts game.comp_ship_placement

puts game.player_ship_placement

puts game.display_boards

puts game.player_turn

puts game.display_boards

puts game.comp_turn

puts game.display_boards