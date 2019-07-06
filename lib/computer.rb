require './lib/ship'
require './lib/board'

class Computer

  def initialize
    @computer_board = Board.new
    @computer_board.create_cells
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_submarine = Ship.new('Submarine', 2)
  end

  def computer_cruiser_placement
    start_point = @computer_board.coordinates[rand(@computer_board.coordinates.count)]
    start_point_array = start_point.chars
    cruiser_location = [start_point]
    starting_letter_ordinal = (start_point_array[0].ord - 64)
    if rand(1..2) == 1
      if start_point_array[1].to_i >= @computer_cruiser.length
        cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 1).to_s)
        cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 2).to_s)
      else start_point_array[1].to_i < @computer_cruiser.length
        cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 1).to_s)
        cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 2).to_s)
      end
    else rand(1..2) == 2
      if starting_letter_ordinal >= @computer_cruiser.length
        cruiser_location.push((starting_letter_ordinal - 1 + 64).chr.to_s + start_point_array[1])
        cruiser_location.push((starting_letter_ordinal - 2 + 64).chr.to_s + start_point_array[1])
      else starting_letter_ordinal < @computer_cruiser.length
        cruiser_location.push((starting_letter_ordinal + 1 + 64).chr.to_s + start_point_array[1])
        cruiser_location.push((starting_letter_ordinal + 2 + 64).chr.to_s + start_point_array[1])
      end
    end
    cruiser_location.sort
  end
end
