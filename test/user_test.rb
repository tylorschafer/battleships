require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/coordinates'
require './lib/user'
require 'pry'

class UserTest < Minitest::Test
  def setup
    @user = User.new
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_user_exits
    assert_instance_of User, @user
  end

  def test_users_has_board_and_ships
    assert_instance_of Board, @user.board
    assert_instance_of Ship, @user.cruiser
    assert_instance_of Ship, @user.submarine
  end

  def test_user_ship_placement
    assert @user.cruiser_placement
    assert @user.submarine_placement
  end
end
