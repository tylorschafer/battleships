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

    assert hit_cell.fired_upon?
  end

  def test_computer_fires_shot
    binding.pry
    @coordinate_collection = ['A1','B1']
    hit_cell = @user.board.cells['B2']
    hit_cell.fire_upon

    assert hit_cell.fired_upon?
  end
end
