# frozen_string_literal: true

require_relative 'deck'
require_relative 'players'
require_relative 'user'
require_relative 'dealer'
require_relative 'tui'

puts 'Это игра в Black Jack!'
puts '======================'

tui = TextUserInterface.new
tui.create_player
tui.beginning_of_game
tui.counter_hand
tui.show_face_of_cards_player
tui.item_selection
