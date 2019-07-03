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


# def consecutive_placement(array = [])
#   split_chars_array = array.map{ |element|element.to_s.chars}
#   numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
#   letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0}
#   nested_con_lets = letter_array.each_cons(2).map {|a| a}
#   nested_con_nums = numbers_array.each_cons(2).map {|a| a}
#   @con_letters = nested_con_lets.flatten.uniq.count
#   @con_numbers = nested_con_nums.flatten.uniq.count
#   @ord_letters = letter_array.map {|letter| letter.ord - 64}
#   @count = array.count
#   if @con_numbers == @count && @con_letters == 1 || @con_letters == @count && @ord_numbers == 1
#     true
#   else
#     false
#   end
# end
