require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'

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
end
