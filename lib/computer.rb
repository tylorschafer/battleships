require './lib/ship'
require './lib/board'
require './lib/coordinates'
require './lib/cell'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @board.create_cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def cruiser_placement
    valid_choice = false
    until valid_choice == true
      start_point = @board.coordinates[rand(@board.coordinates.count)]
      start_point_array = start_point.chars
      cruiser_location = [start_point]
      starting_letter_ordinal = (start_point_array[0].ord - 64)
      if rand(1..2) == 1
        if start_point_array[1].to_i >= @cruiser.length
          cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 1).to_s)
          cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i - 2).to_s)
        else start_point_array[1].to_i < @cruiser.length
          cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 1).to_s)
          cruiser_location.push(start_point_array[0] + (start_point_array[1].to_i + 2).to_s)
        end
      else rand(1..2) == 2
        if starting_letter_ordinal >= @cruiser.length
          cruiser_location.push((starting_letter_ordinal - 1 + 64).chr.to_s + start_point_array[1])
          cruiser_location.push((starting_letter_ordinal - 2 + 64).chr.to_s + start_point_array[1])
        else starting_letter_ordinal < @cruiser.length
          cruiser_location.push((starting_letter_ordinal + 1 + 64).chr.to_s + start_point_array[1])
          cruiser_location.push((starting_letter_ordinal + 2 + 64).chr.to_s + start_point_array[1])
        end
      end
      cruiser_location = cruiser_location.sort
      if @board.valid_placement?(@cruiser, cruiser_location)
        @board.place(@cruiser, cruiser_location)
        valid_choice = true
      else
        puts 'Cruiser placement invalid'
        next
      end
    end
    valid_choice
  end

  def submarine_placement
    valid_choice = false
    until valid_choice == true
      start_point = @board.coordinates[rand(@board.coordinates.count)]
      start_point_array = start_point.chars
      submarine_location = [start_point]
      starting_letter_ordinal = (start_point_array[0].ord - 64)
      if rand(1..2) == 1
        if start_point_array[1].to_i == 4
          submarine_location.push(start_point_array[0] + (start_point_array[1].to_i - 1).to_s)
        else start_point_array[1].to_i <= 3
          submarine_location.push(start_point_array[0] + (start_point_array[1].to_i + 1).to_s)
        end
      else rand(1..2) == 2
        if starting_letter_ordinal == 4
          submarine_location.push((starting_letter_ordinal - 1 + 64).chr.to_s + start_point_array[1])
        else starting_letter_ordinal <= 3
          submarine_location.push((starting_letter_ordinal + 1 + 64).chr.to_s + start_point_array[1])
        end
      end
      submarine_location = submarine_location.sort
      if @board.valid_placement?(@submarine, submarine_location) == true
        @board.place(@submarine, submarine_location)
        valid_choice = true
      else
        puts 'Submarine placement invalid'
        next
      end
    end
    valid_choice
  end
end
