require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/cell'
require './lib/coordinates'
require './lib/ship'
require './lib/battle_summary'
require 'colorize'

class Turn

  attr_reader :turn_collection, :coordinate_collection

  def initialize(computer, user)
    @computer = computer
    @user = user
    @turn_collection = ['xxx']
    @coordinate_collection = []
    @user_cells = @user.board.cells
    @battle = BattleSummary.new(@computer,@user)
  end

  def display_both_boards
    @battle.computer_summary
    @computer.board.render
    @battle.user_summary
    @user.board.render(true)
  end

  def user_shot_result
    case
      when @computer.board.cells[@fire_selection].empty? == true
        'miss'.blue
      when  @computer.board.cells[@fire_selection].cell_contents[0].name == 'Submarine' && @computer.submarine.sunk?
        'hit'.red + ' and' + ' sunk'.red + ' my Submarine' + " \u{1F480}"
      when @computer.board.cells[@fire_selection].cell_contents[0].name == 'Cruiser' && @computer.cruiser.sunk?
        'hit'.red + ' and' + ' sunk'.red + ' my Cruiser' + " \u{1F480}"
      when @computer.board.cells[@fire_selection].empty? == false
        'hit'.red
      end
    end

  def user_fires_shot
    puts 'Enter the coordinate for your shot:'
    valid_selection = false
    until valid_selection == true
      @fire_selection = gets.chomp.upcase
      if @computer.board.valid_coordinate?(@fire_selection) && @computer.board.cells[@fire_selection].fired_upon? == false
        @computer.board.cells[@fire_selection].fire_upon
        valid_selection = true
      elsif @computer.board.valid_coordinate?(@fire_selection) == false
        puts 'Your selection is invalid. Please choose a coordinate within the board:'
      else
        puts 'You have already fired upon this location. Please select another:'
        next
      end
    end
    user_response = puts "Your shot on #{@fire_selection} was a #{user_shot_result}"
    user_response
  end

  def computer_shot_result
    case
    when @user.board.cells[@computer_selection].empty? == true
      @turn_collection << 'miss'
      'miss'.blue
    when @user.board.cells[@computer_selection].cell_contents[0].name == 'Cruiser' && @user.cruiser.sunk?
      @turn_collection << 'hit and sunk your Cruiser'
      'hit'.red + ' and' + ' sunk'.red + ' your Cruiser' + " \u{1F480}"
    when @user.board.cells[@computer_selection].cell_contents[0].name == 'submarine' && @user.submarine.sunk?
      @turn_collection << 'hit and sunk your Submarine'
      'hit'.red + ' and' ' sunk'.red + ' your Submarine' + " \u{1F480}"
    when @user.board.cells[@computer_selection].empty? == false
      @turn_collection << 'hit'
      'hit'.red
    end
  end

def computer_take_shot
  @user_cells[@computer_selection].fire_upon
  @valid_choice = true
  @coordinate_collection << @computer_selection
end

  def computer_smart_firing
    user_coordinates = @user.board.coordinates
    last_coordinate = user_coordinates.find{|coor|(coor == @coordinate_collection.last)}
    @valid_choice = false
    until @valid_choice == true
      if @turn_collection.last.include?('hit') == true && @turn_collection.last.include?('sunk') == false
          @computer_selection = user_coordinates[user_coordinates.index(last_coordinate) + 1]
        if @user_cells[@computer_selection].fired_upon? == false
          computer_take_shot
        else
          @computer_selection = @user.board.coordinates.sample
          if @user_cells[@computer_selection].fired_upon? == false
            computer_take_shot
          end
        end
      else
        @computer_selection = @user.board.coordinates.sample
          if @user_cells[@computer_selection].fired_upon? == false
          computer_take_shot
          end
      end
    end
    computer_response = puts "My shot on #{@computer_selection} was a #{computer_shot_result}"
    computer_response
  end

  def check_for_winner
    if @computer.cruiser.sunk? && @computer.submarine.sunk?
      puts "You won! \u{1F973}"
      display_both_boards
    else
      computer_smart_firing
      if @user.cruiser.sunk? && @user.submarine.sunk?
        puts "I won! \u{1F92A}"
        display_both_boards
      else
        display_both_boards
      end
    end
  end

  def take
    user_fires_shot
    check_for_winner
  end
end
