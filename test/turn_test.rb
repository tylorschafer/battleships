require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/cell'

class TurnTest < Minitest::Test
  def setup
    @computer = Computer.new(4,4)
    @user = User.new(4,4)
    @user.board.create_cells
    @computer.board.create_cells
    @turn = Turn.new(@computer, @user)
  end
  def test_turn_exists
    assert_instance_of Turn, @turn
  end

  def test_turn_has_boards
    assert_instance_of Board, @computer.board
    assert_instance_of Board, @user.board
  end

  def test_user_fires_shot
    hit_cell = @computer.board.cells['A1']
    hit_cell.fire_upon
    assert @turn.user_fires_shot
  end

  def test_computer_fires_shot
    binding.pry
    @coordinate_collection = ['C1','B1','A1']
    @user_coordinates = @user.board.coordinates
    @last_coordinate = @user_coordinates.find{|coor|(coor == @coordinate_collection.last)}
    assert_equal 'A1', @last_coordinate
    assert_equal 'B1' || 'A2', @user_coordinates[@user_coordinates.index(@last_coordinate) + 1]
    @coordinate_collection = ['A1','A4','B2']
    assert_equal 'B1' || 'C2', @user_coordinates[@user_coordinates.index(@last_coordinate) + 1]
    assert "My shot on  was a .", @turn.computer_smart_firing
  end
end
