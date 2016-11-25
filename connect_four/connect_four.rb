# Connect Four

# program collector

require './connect_four_game.rb'
# require './test.rb'
# require './test2.rb'
require './connect_four_board'
require './connect_four_player'       # delete? See no use for this
require './connect_four_human'
require './connect_four_computer'

# Includes the ConnectFour
# module into the global
# namespace
include ConnectFour


# Play!

puts "Ready to play ... please wait"
sleep(1)

Game.new.play




