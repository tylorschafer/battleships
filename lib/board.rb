require './lib/coordinates'

class Board
  attr_reader :cells, :cell, :coordinates

  def initialize
    @coordinates = Coordinates.new.run
    @cell = cell
    @cells = Hash.new
  end

  def create_cells
    @coordinates.each do |coord|
      @cells[coord] = Cell.new(coord)
    end
  end

  def validate_coordinate?(coord)
    @coordinates.include?(coord)
  end

  def valid_placement?(ship, coordinates = [])
    (coordinates.count == ship.health)
  end
end


def consecutive_placement(array = [])
  split_chars_array = array.map{ |element|element.to_s.chars} (chars splits array into individual elements)
  numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
  letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0} sort string into # or letter array
#   @con_letters = letter_array.flatten.uniq.count flatten and unique to potentially determine if consecutive
#   @con_numbers = numbers_array.flatten.uniq.count
#   @ord_letters = letter_array.map {|letter| letter.ord - 64}
#   @count = array.count stored just to reference
# end

.zip method creates nested array to make coordinates
