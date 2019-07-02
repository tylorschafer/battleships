require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test

  def setup
    @cell = Cell.new('B4')
  end

  def test_cell_exsists
    assert_instance_of Cell, @cell
  end

  def test_cell_returns_proper_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_cell_starts_with_no_ship
    assert_equal nil, @cell.ship
  end

  def test_cell_starts_empty
    assert_equal true, @cell.empty?
  end

  def test_cell_can_add_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_instance_of Ship, @cell.ship
  end

  def test_cell_is_not_empty_with_ship_placed
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal false, @cell.empty?
  end

end
