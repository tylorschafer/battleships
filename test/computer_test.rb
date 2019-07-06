require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'
require './lib/computer'

class ComputerTest < Minitest::Test
  def setup
    @computer = Computer.new
    @computer_board = Board.new
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_submarine = Ship.new('Submarine', 2)
  end

  def test_computer_exists
    assert_instance_of Computer, @computer
  end

  def test_computer_has_board_and_ships
    assert_instance_of Board, @computer_board
    assert_instance_of Ship, @computer_cruiser
    assert_instance_of Ship, @computer_submarine
  end
### ASK ABOUT THIS TEST BELOW - WHAT TO TEST BECAUSE IT'S RANDOM
  def test_random_computer_cruiser_placement
    assert_equal 3, @computer.computer_cruiser_placement.count
  end
end
