require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  
  def setup
    @cruiser = Ship.new('Cruiser', 3)
  end

  def test_ship_exists
    assert Ship, @cruiser
  end

  def test_attributes
    assert 'Cruiser', @cruiser.name
    assert 3, @cruiser.length
    assert 3, @cruiser.health
  end

  def test_to_start_ship_is_not_sunk
    refute @cruiser.sunk?
  end

  def test_cruiser_hit
    @cruiser.hit
    assert 2, @cruiser.health
    @cruiser.hit
    assert 1, @cruiser.health
    @cruiser.hit
    assert 0, @cruiser.health
  end

  def test_cruiser_sunk?
    3.times do
      @cruiser.hit
    end
    assert @cruiser.sunk?
  end
end
