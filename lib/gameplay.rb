require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'
require './lib/computer'
require './lib/user'

def start_game
  puts 'Welcome to BATTLESHIP'
  puts 'Enter p to play. Enter q to quit.'
  p_or_q = gets.chomp
  if p_or_q.downcase == 'q'
    puts 'Goodbye'
  elsif p_or_q.downcase == 'p'
    play_game
  else
    puts 'Invalid input'
  end
end

def play_game
  computer = Computer.new
  computer.cruiser_placement
  computer.submarine_placement
  user = User.new
  puts 'I have laid out my ships on the grid.'
  puts 'You now need to lay out your two ships on the grid.'
  puts 'The Criser is three units long and the Submarine is two units long.'
  user.board.render
  user.cruiser_placement
  user.submarine_placement
end

start_game
