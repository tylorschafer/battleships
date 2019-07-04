require './lib/coordinates'
require './lib/cell'

class Board
  attr_reader :cell, :coordinates, :cells

  def initialize
    @coordinates = Coordinates.new.run
    @cell = cell
    @cells = Hash.new
  end

  def cells
    @coordinates.each do |coord|
      @cells[coord] = Cell.new(coord)
    end
    @cells
  end

  def valid_coordinate?(coord)
    @coordinates.include?(coord)
  end

  def valid_placement?(ship, coordinates = [])
    # coordinates.count == ship.health
    # split_chars_array = coordinates.map{ |element|element.to_s.chars} # (chars splits array into individual elements)
    # numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
    # letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0} # sort string into # or letter array
    # @con_letters = letter_array.flatten.uniq.count # flatten and unique to potentially determine if consecutive
    # @con_numbers = numbers_array.flatten.uniq.count
    # @ord_letters = letter_array.map {|letter| letter.ord - 64}
    # @ord_numbers = numbers_array.map {|number| number.ord - 64}
    # require "pry"; binding.pry
    # # @count = coordinates.count #stored just to reference
    # If all of the conditionals below are true then its truly a valid placement. Code should breakout as soon as it hits false
    if coordinates.count == ship.health
    elsif (next conditional statement)
    elsif (another conditional statement)
    elsif (next condtional statement)
    else (final conditional statement)
    end
  end
end

# .zip method creates nested array to make coordinates
