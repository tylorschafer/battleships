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
    puts '=============COMPUTER BOARD============='
    @computer.board.render
    puts '==============PLAYER BOARD=============='
    @user.board.render(true)
  end

  def user_fires_shot
    puts 'Enter the coordinate for your shot:'
    valid_selection = false
    until valid_selection == true
      @fire_selection = gets.chomp.upcase
      if @computer.board.valid_coordinate?(@fire_selection) && @computer.board.cells[@fire_selection].fired_upon? == false
        @computer.board.cells[@fire_selection].fire_upon
        valid_selection = true
      else
        puts 'You have already fired upon this location. Please select another:'
        @fire_selection = gets.chomp.upcase
      end
      ### still need to loop the invalid selection and fire upon once valid

    end
    puts "Your shot on #{@fire_selection} was a #{user_shot_result}."
  end

  def user_shot_result
    case
    when @computer.board.cells[@fire_selection].cell_contents == []
      puts 'miss'
    when @computer.board.cells[@fire_selection].cell_contents == Ship
      puts 'hit'
    when @computer.board.cells[@fire_selection].cell_contents == Ship && (@computer.cruiser.sunk? || @computer.submarine.sunk?)
      puts 'hit and sunk a ship'
    end
  end

  def computer_shot_result
    case
    when @user.board.cells[@computer_selection].cell_contents == []
      puts 'miss'
    when @user.board.cells[@computer_selection].cell_contents == Ship
      puts 'hit'
    when @user.board.cells[@computer_selection].cell_contents == Ship && (@user.cruiser.sunk? || @user.submarine.sunk?)
      puts 'hit and sunk a ship'
    end
  end

  def computer_fires_shot
    valid_selection = false
    until valid_selection == true
      @computer_selection = @user.board.coordinates.sample
      if @user.board.cells[@computer_selection].fired_upon? == false
        @user.board.cells[@computer_selection].fire_upon
        valid_selection = true
      end
    end
    puts "My shot on #{@computer_selection} was a #{computer_shot_result}."
  end

  def take
    display_both_boards
    user_fires_shot
    computer_fires_shot
    display_both_boards
  end
end
