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
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_computer_exists
    assert_instance_of Computer, @computer
  end

  def test_computer_has_board_and_ships
    assert_instance_of Board, @board
    assert_instance_of Ship, @cruiser
    assert_instance_of Ship, @submarine
  end

  def test_computer_ship_placement
    assert @computer.submarine_placement
    assert @computer.cruiser_placement
  end
end
