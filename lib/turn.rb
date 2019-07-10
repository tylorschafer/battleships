require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/cell'
require './lib/coordinates'
require './lib/ship'
require 'pry'

class Turn

  attr_reader :turn_collection, :coordinate_collection

  def initialize(computer, user)
    @computer = computer
    @user = user
    @user_coordinates = @user.board.coordinates
    @turn_collection = ['xxx']
    @coordinate_collection = []
  end

  def display_both_boards
    puts '=============COMPUTER BOARD============='
    @computer.board.render
    puts '==============PLAYER BOARD=============='
    @user.board.render(true)
  end

  def user_shot_result
    case
      when @computer.board.cells[@fire_selection].empty? == true
        'miss'
      when  @computer.board.cells[@fire_selection].cell_contents[0].name == 'Submarine' && @computer.submarine.sunk?
        'hit and sunk my Submarine'
      when @computer.board.cells[@fire_selection].cell_contents[0].name == 'Cruiser' && @computer.cruiser.sunk?
        'hit and sunk my Cruiser'
      when @computer.board.cells[@fire_selection].empty? == false
        'hit'
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
      else
        puts 'You have already fired upon this location. Please select another:'
        next
      end
    end
    user_response = puts "Your shot on #{@fire_selection} was a #{user_shot_result}."
    user_response
  end

  def computer_shot_result
    case
    when @user.board.cells[@computer_selection].empty? == true
      @turn_collection << 'miss'
      'miss'
    when @user.board.cells[@computer_selection].cell_contents[0].name == 'Cruiser' && @user.cruiser.sunk?
      @turn_collection << 'hit and sunk your Cruiser'
      'hit and sunk your Cruiser'
    when @user.board.cells[@computer_selection].cell_contents[0].name == 'submarine' && @user.submarine.sunk?
      @turn_collection << 'hit and sunk your Submarine'
      'hit and sunk your Submarine'
    when @user.board.cells[@computer_selection].empty? == false
      @turn_collection << 'hit'
      'hit'
    end
  end

    def computer_smart_firing
      @last_coordinate = @user_coordinates.find{|coor|(coor == @coordinate_collection.last)}
      valid_choice = false
      until valid_choice == true
        if @turn_collection.last.include?('hit') == true && @turn_collection.last.include?('sunk') == false
            @computer_selection = @user_coordinates[@user_coordinates.index(@last_coordinate) + 1]
          if @user.board.cells[@computer_selection].fired_upon? == false
            @user.board.cells[@computer_selection].fire_upon
            valid_choice = true
            @coordinate_collection << @computer_selection
          else
            @computer_selection = @user.board.coordinates.sample
            if @user.board.cells[@computer_selection].fired_upon? == false
              @user.board.cells[@computer_selection].fire_upon
              valid_choice = true
              @coordinate_collection << @computer_selection
            end
          end
        else
          @computer_selection = @user.board.coordinates.sample
          if @user.board.cells[@computer_selection].fired_upon? == false
            @user.board.cells[@computer_selection].fire_upon
            valid_choice = true
            @coordinate_collection << @computer_selection
          end
        end
      end
      computer_response = puts "My shot on #{@computer_selection} was a #{computer_shot_result}."
      computer_response
    end

  def take
    user_fires_shot
    computer_smart_firing
    display_both_boards
  end
end
