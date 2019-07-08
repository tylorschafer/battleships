require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/cell'
require './lib/coordinates'
require './lib/ship'

class Turn
  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def display_both_boards
    @computer.board.render
    @user.board.render(true)
  end

  def user_fires_shot
    puts 'Enter the coodinate for your shot:'
    valid_selection = false
    until valid_selection == true
      fire_selection = 'C1'
      if @computer.board.valid_coordinate?(fire_selection) && @computer.board.cells[fire_selection].fired_upon? == false
        @computer.board.cells[fire_selection.upcase].fire_upon
        valid_selection = true
      else
        puts 'Please enter valid coordinate:'
        next
      end
    end
  end

  def computer_fires_shot
    computer_selection = @user.board.coordinates.sample
    valid_selection = false
    until valid_selection == true
      if @user.board.cells[computer_selection].fired_upon? == false
        @user.board.cells[computer_selection].fire_upon
        valid_selection = true
      end
    end
  end

  def take
    display_both_boards
    user_fires_shot
    computer_fires_shot
    display_both_boards
  end
end
