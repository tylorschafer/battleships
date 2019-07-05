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
    assert_instance_of Coordinates, @coordinates
  end

  def test_x_value_to_letter
    assert_equal 'D', @coordinates.to_letter
  end

  def test_create_y_array
    assert_equal "1", @coordinates.y_loader[0]
  end

  def test_create_x_array
    assert_equal "A", @coordinates.x_loader[0]
  end

  def test_add_x_and_x_together
    @coordinates.x_loader
    @coordinates.y_loader

    assert_equal "A1", @coordinates.add_x_and_y.first
  end

  def test_coords
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"], @coordinates.add_x_and_y
  end
end
