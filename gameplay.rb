require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'
require './lib/computer'
require './lib/user'
require './lib/turn'

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
    start_game
  end
end

def play_game
  puts 'Lets choose what size board you would like to play on.'
  valid_length = false
  until valid_length == true
    puts 'Please enter the length for your board. (Minimum size 3, Maximum size 26)'
    user_length = gets.chomp.to_i
      if user_length < 3 || user_length > 26
        puts 'Sorry, that is an invalid board size.'
      else
        valid_length == true
        break
      end
    end
  valid_width = false
  until valid_width == true
    puts 'Now please enter a width for your board. (Minimum size 3, Maximum size 10)'
    user_width = gets.chomp.to_i
      if user_width < 3 || user_width > 10
        puts 'Sorry, that is an invalid board size.'
      else
        valid_width = true
        break
      end
    end

  @computer = Computer.new(user_length, user_width)
  @computer.ship_placement(@computer.cruiser)
  @computer.ship_placement(@computer.submarine)
  @user = User.new(user_length, user_width)

  puts 'I have laid out my ships on the grid.'
  puts 'You now need to lay out your two ships on the grid.'
  puts 'The Cruiser is three units long and the Submarine is two units long.'

  @user.board.render(true)
  @user.cruiser_placement
  @user.submarine_placement
  turn = Turn.new(@computer, @user)
  turn.display_both_boards
  until @computer.cruiser.sunk? && @computer.submarine.sunk? || @user.cruiser.sunk? && @user.submarine.sunk? do
    turn.take
  end
  start_game
end

start_game
