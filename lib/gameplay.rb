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
  @computer_board = Board.new
  @computer_board.create_cells
  @user_board = Board.new
  @user_board.create_cells


end

def ship_placement_computer
  @computer_cruiser = Ship.new('Cruiser', 3)
  @computer_submarine = Ship.new('Submarine', 2)

end

def ship_placement_user
  @user_cruiser = Ship.new('Cruiser', 3)
  @user_submarine = Ship.new('Submarine', 2)
  user_cruiser_placement = rand(@coorindates)
end
