require 'minitest/autorun'
require 'minitest/pride'
require './lib/coordinates'



class CoordinatesTest < Minitest::Test

  def setup
    @coordinates = Coordinates.new
    @coordinates.x_loader
    @coordinates.y_loader
    @coordinates.add_x_and_y
  end

  def test_coordinates_exists
    assert Coordinates, @coordinates
  end

  def test_x_value_to_letter
    assert 'ABCD', @coordinates.to_letter
  end

  def test_create_y_array
    assert '1', @coordinates.y_loader[0]
    assert '2', @coordinates.y_loader[1]
    assert '3', @coordinates.y_loader[2]
    assert '4', @coordinates.y_loader[3]
    assert '1', @coordinates.y_loader[4]
  end

  def test_create_x_array
    assert 'A', @coordinates.x_loader[0]
    assert 'B', @coordinates.x_loader[1]
    assert 'C', @coordinates.x_loader[2]
    assert 'D', @coordinates.x_loader[3]
    assert 'E', @coordinates.x_loader[4]
  end

  def test_add_x_and_x_together
    @coordinates.x_loader
    @coordinates.y_loader
    assert 'A1', @coordinates.add_x_and_y.first
    assert 'D4', @coordinates.add_x_and_y.last
  end

  def test_coords
    assert ['A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4'], @coordinates.add_x_and_y
  end
end
