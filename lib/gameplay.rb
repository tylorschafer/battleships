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
  @computer_cruiser = Ship.new('Cruiser', 3)
  @computer_submarine = Ship.new('Submarine', 2)
  @user_cruiser = Ship.new('Cruiser', 3)
  @user_submarine = Ship.new('Submarine', 2)
end

def computer_cruiser_placement
  start_point = @computer_board.coordinates[rand(@computer_board.coordinates.count)]
  start_point_array = start_point.chars
  cruiser_location = [start_point]
  if rand(1...2) == 1
    if start_point_array[1].to_i >= @computer_cruiser.length
      cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 1).to_s)
      cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 2).to_s)
    else start_point_array[1].to_i < @computer_cruiser.length
      cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 1).to_s)
      cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 2).to_s)
    end
  else rand(1...2) == 2
    
  end
end
