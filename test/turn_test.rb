require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/cell'
require 'pry'

class TurnTest < Minitest::Test
  def setup
    @turn = Turn.new
    @computer = Computer.new
    @user = User.new
    @user.board.create_cells
    @computer.cruiser_placement
    @computer.submarine_placement
    @computer.board.create_cells
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
    hit_cell = @user.board.cells['B2']
    hit_cell.fire_upon

    assert hit_cell.fired_upon?
  end
end
