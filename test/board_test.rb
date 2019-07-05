require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_is_a_hash
    assert Hash.new, @board
  end

  def test_cells_created
    assert @board.cells.include?('A1')
  end

  def test_board_has_16_cells_and_each_key_is_cell
    assert_equal 16, @board.cells.count
  end

  def test_valid_coordinate?
    assert @board.valid_coordinate?('A1')
    assert @board.valid_coordinate?('D4')
    refute @board.valid_coordinate?('A5')
    refute @board.valid_coordinate?('E1')
    refute @board.valid_coordinate?('A22')
  end

  def test_valid_placement_coordinates_same_as_ship_length
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_additional_placements
    assert_equal true, @board.valid_placement?(@cruiser, ['A1','B1','C1'])
    assert_equal true, @board.valid_placement?(@submarine, ['C1','C2'])
  end

  def test_valid_placement_coordinates_are_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ['A1', 'A2', 'A4'])
    assert_equal true, @board.valid_placement?(@cruiser, ['A1', 'A2', 'A3'])
    assert_equal false, @board.valid_placement?(@submarine, ['A1', 'C1'])
    assert_equal false, @board.valid_placement?(@cruiser, ['A3', 'A2', 'A1'])
  end

  def test_valid_placement_coordinates_are_not_diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ['A3', 'B2', 'C1'])
    assert_equal false, @board.valid_placement?(@submarine, ['C2', 'D3'])
  end

  def test_place_ship
    assert @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
    assert @cell_3.ship == @cell_2.ship
  end

  def test_no_overlapping_ships
    refute @board.valid_placement?(@submarine, ["A1", "B1"])
  end

end
