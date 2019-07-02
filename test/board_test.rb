require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_is_a_hash
    assert Hash.new, @board
  end

  def test_board_has_16_cells_and_each_key_is_cell
    # assert_equal 16, @board.count
    assert_equal Cell.new, @board["A1"]
  end

  def test_validate_coordinate?
    assert_equal true, @board.validate_coordinate?("A1")
  end
end
