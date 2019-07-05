require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new(:Cruiser, 3)
    @submarine = Ship.new(:Submarine, 2)
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_is_a_hash
    assert Hash.new, @board
  end

  def test_board_has_16_cells_and_each_key_is_cell
    assert_equal 16, @board.cells.count
  end

  def test_validate_coordinate?
    assert_equal true, @board.validate_coordinate?(:A1)
  end

  def test_valid_placement_coordinates_same_as_ship_length
    assert_equal false, @board.valid_placement?(@cruiser, [:A1, :A2])
    assert_equal true, @board.valid_placement?(@submarine, [:A1, :A2])
  end

  def test_valid_placement_coordinates_are_consecutive
    skip
    assert_equal false, @board.valid_placement?(@cruiser, [:A1, :A2, :A4])
    assert_equal true, @board.valid_placement?(@cruiser, [:A1, :A2, :A3])
    assert_equal false, @board.valid_placement?(@submarine, [:A1, :C1])
    assert_equal false, @board.valid_placement?(@cruiser, [:A3, :A2, :A1])
  end

  def test_valid_placement_coordinates_are_not_diagonal
    skip
    assert_equal false, @board.valid_placement?(@cruiser, [:A3, :B2, :C1])
    assert_equal false, @board.valid_placement?(@submarine, [:C2, :D3])
  end

end
