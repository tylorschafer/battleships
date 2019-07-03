require 'minitest/autorun'
require 'minitest/pride'
require './lib/coordinates'



class CoordinatesTest < Minitest::Test

  def setup
    @coordinates = Coordinates.new

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
end
