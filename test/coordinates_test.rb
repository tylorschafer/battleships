require 'minitest/autorun'
require 'minitest/pride'
require './lib/coordinates'
require 'pry'



class CoordinatesTest < Minitest::Test

  def setup
    @coordinates = Coordinates.new
  end

  def test_coordinates_exists
    assert_instance_of Coordinates, @coordinates
  end

  def test_x_value_to_letter
    assert_equal "D", @coordinates.to_letter
  end

  def test_create_y_array
    @coordinates.y_loader
    assert_equal 1, @y_array[0]
  end
end
