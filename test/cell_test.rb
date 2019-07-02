require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C4")
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
    skip
    assert_equal true, @cell.empty?
  end

  def test_cell_can_add_ship
    skip
    @cell.place_ship(@cruiser)
    assert_instance_of Ship, @cell.ship
  end

  def test_cell_is_not_empty_with_ship_placed
    skip
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end

  def test_cell_knows_when_fired_upon
    skip
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_ship_on_cell_takes_damage_when_fired_upon
    skip
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @ship.health
  end

  def test_cell_renders_properly
    skip
    assert_equal ".", @cell_1.render
    @cell_1.fire_upon
    assert_equal "M", @cell_1.render
    @cell_2.place_ship(@cruiser)
    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)
  end

  def test_cell_renders_when_ship_hit
    skip
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell_2.render
  end
end
