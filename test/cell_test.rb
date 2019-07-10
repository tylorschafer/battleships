require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new('B4')
    @cell_2 = Cell.new('C4')
    @cruiser = Ship.new('Cruiser',3)
  end

  def test_cell_exsists
    assert Cell, @cell
  end

  def test_cell_returns_proper_coordinate
    assert 'B4', @cell.coordinate
  end

  def test_cell_starts_with_no_ship
    assert_nil nil, @cell.ship
  end

  def test_cell_starts_empty
    assert [], @cell.cell_contents
    assert @cell.empty?
  end

  def test_cell_can_add_ship
    @cell.place_ship(@cruiser)
    assert Ship, @cell.ship
  end

  def test_cell_is_not_empty_with_ship_placed
    @cell.place_ship(@cruiser)
    refute @cell.empty?
  end

  def test_cell_knows_when_fired_upon
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?
    @cell.fire_upon
    assert @cell.fired_upon?
  end

  def test_ship_on_cell_takes_damage_when_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert 2, @cruiser.health
  end

  def test_cell_renders_properly
    assert '.', @cell.render
    @cell.fire_upon
    assert 'M', @cell.render
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert 'H', @cell.render
    assert 'S', @cell.render(true)
    @cell.fire_upon
    @cell.fire_upon
    assert 'X', @cell.render
  end

  def test_cell_renders_when_ship_hit_or_sunk
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert 'H', @cell_2.render
    refute @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert true, @cruiser.sunk?
    assert 'X', @cell_2.render
    assert 'S', @cell_2.render
    assert '.', @cell.render
  end
end
