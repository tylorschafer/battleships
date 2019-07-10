require './lib/ship'
require './lib/board'
require './lib/coordinates'
require './lib/cell'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize(length, width)
    @board = Board.new(length, width)
    @board.create_cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def ship_placement(ship)
    valid_choice = false
    until valid_choice == true
      start_point = @board.coordinates.sample
      start_point_array = start_point.chars
      location = [start_point]
      starting_letter_ordinal = (start_point_array[0].ord - 64)
      if rand(1..2) == 1
        (ship.length - 1).times do |num|
          location.push(start_point_array[0] + (start_point_array[1].to_i + num + 1).to_s)
        end
      else rand(1..2) == 2
        (ship.length - 1).times do |num|
          location.push((starting_letter_ordinal + num + 1 + 64).chr.to_s + start_point_array[1])
        end
      end
      if @board.valid_placement?(ship, location)
        @board.place(ship, location)
        valid_choice = true
      end
    end
    valid_choice
  end
end
