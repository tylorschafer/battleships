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
    @cell_1 = @board.cells['A1']
    @cell_2 = @board.cells['A2']
    @cell_3 = @board.cells['A3']
    @cell_4 = @board.cells['A4']
    @cell_16 = @board.cells['D4']
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_is_a_hash
    assert Hash.new, @board
  end

  def test_cells_created
    assert @board.cells.include?('A1')
    assert @board.cells.include?('D4')
    refute @board.cells.include?('A5')
    refute @board.cells.include?('E1')
  end

  def test_board_has_16_cells_and_key_is_cell
    assert_equal 16, @board.cells.count
    assert Cell, @board.cells['A1']
    assert Cell, @board.cells['D4']
  end

  def test_variable_board_sizes
    @big_board = Board.new(10, 10)

    assert_equal 100, @big_board.cells.count
    assert Cell, @big_board.cells['A10']
    assert Cell, @big_board.cells['E6']
    assert Cell, @big_board.cells['J10']
  end

  def test_valid_coordinate?
    assert @board.valid_coordinate?('A1')
    assert @board.valid_coordinate?('D4')
    refute @board.valid_coordinate?('A5')
    refute @board.valid_coordinate?('E1')
    refute @board.valid_coordinate?('A22')
    assert @board.valid_coordinate?('A1','A2')
    refute @board.valid_coordinate?('A3','A4','A5')
  end

  def test_coordinate_count_equal_to_length?
    assert @board.coordinate_count_equal_to_length?(@cruiser, ['A1', 'A2', 'A3'])
    refute @board.coordinate_count_equal_to_length?(@cruiser, ['A1', 'A2'])
    assert @board.valid_placement?(@submarine, ['A1', 'A2'])
    refute @board.valid_placement?(@submarine, ['A2', 'A3', 'A4'])
  end

  def test_create_uniq_numbers
    assert ['2','2','2'] != @board.create_uniq_numbers(['A2','B2','C2'])
    assert ['1','2','3'], @board.create_uniq_numbers(['A1','A2','A3'])
    assert_equal ['8','9','10'], @board.create_uniq_numbers(['A8','A9','A10'])
    assert ['1'], @board.create_uniq_numbers(['A1','B1','C1'])
    assert ['4'], @board.create_uniq_numbers(['B4','C4','D4'])
  end

  def test_create_uniq_letters
    assert [1,1,1] != @board.create_uniq_letters(['A1','A2','A3'])
    assert [1], @board.create_uniq_letters(['A1','A2','A3'])
    assert [3], @board.create_uniq_letters(['C1','C2','C3'])
    assert [1,2,3], @board.create_uniq_letters(['A1','B1','C1'])
  end

  def test_consecutive_numbers?
    @board.create_uniq_numbers(['A1','A2','A3'])
    @board.create_uniq_letters(['A1','A2','A3'])
    assert @board.consecutive_numbers?(@cruiser)
    refute @board.consecutive_numbers?(@submarine)
    @board.create_uniq_numbers(['A1','A3','A4'])
    @board.create_uniq_letters(['A1','A3','A4'])
    refute @board.consecutive_numbers?(@cruiser)
    @board.create_uniq_numbers(['A8','A9','A10'])
    @board.create_uniq_letters(['A8','A9','A10'])
    assert @board.consecutive_numbers?(@cruiser)
  end

  def test_consecutive_letters?
    @board.create_uniq_numbers(['A1','B1','C1'])
    @board.create_uniq_letters(['A1','B1','C1'])
    assert @board.consecutive_letters?(@cruiser)
    refute @board.consecutive_letters?(@submarine)

    @board.create_uniq_numbers(['A1','B1','D1'])
    @board.create_uniq_letters(['A1','B1','D1'])
    refute @board.consecutive_letters?(@cruiser)
  end

  def test_valid_placement_contains_all_methods
    assert @board.valid_placement?(@cruiser, ['A1','A2','A3'])
    refute @board.valid_placement?(@cruiser, ['A1','A2','A4'])
    assert @board.valid_placement?(@cruiser, ['B1','C1','D1'])
    refute @board.valid_placement?(@cruiser, ['A1','C1','D1'])
    refute @board.valid_placement?(@submarine, ['A1','A2','A3'])
    refute @board.valid_placement?(@cruiser, ['A1','A2'])
  end

  def test_valid_placement_coordinates_are_not_diagonal
    refute @board.valid_placement?(@cruiser, ['A3','B2','C1'])
    refute @board.valid_placement?(@submarine, ['C2','D3'])
  end

  def test_place_ship
    assert @board.place(@cruiser, ['A1','A2','A3'])
    assert @cruiser, @cell_1.ship
    assert @cruiser, @cell_2.ship
    assert @cruiser, @cell_3.ship
    assert @cell_3.ship == @cell_2.ship
  end

  def test_no_overlapping_ships
    @board.place(@cruiser, ['A1','A2','A3'])
    refute  @board.overlapping_ships?(['A1','A2'])
    assert  @board.overlapping_ships?(['B1','B2'])
    refute  @board.valid_placement?(@submarine, ['A1','B1'])
    assert  @board.valid_placement?(@submarine, ['D1','D2'])
  end

  def test_board_render
    assert_equal "   1 2 3 4 \n A . . . . \n B . . . . \n C . . . . \n D . . . . \n", @board.render
    @board.place(@cruiser, ['A1','A2','A3'])
    assert_equal "   1 2 3 4 \n A . . . . \n B . . . . \n C . . . . \n D . . . . \n", @board.render
    assert_equal "   1 2 3 4 \n A S S S . \n B . . . . \n C . . . . \n D . . . . \n", @board.render(true)
    @cell_1.fire_upon
    assert_equal "   1 2 3 4 \n A H . . . \n B . . . . \n C . . . . \n D . . . . \n", @board.render
    assert_equal "   1 2 3 4 \n A H S S . \n B . . . . \n C . . . . \n D . . . . \n", @board.render(true)
    @cell_4.fire_upon
    @cell_16.fire_upon
    assert_equal "   1 2 3 4 \n A H S S M \n B . . . . \n C . . . . \n D . . . M \n", @board.render(true)
    @board.place(@submarine, ['C1','D1'])
    assert_equal "   1 2 3 4 \n A H . . M \n B . . . . \n C . . . . \n D . . . M \n", @board.render
    assert_equal "   1 2 3 4 \n A H S S M \n B . . . . \n C S . . . \n D S . . M \n", @board.render(true)
  end
end
