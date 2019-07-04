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

  def valid_placement?(ship, ship_coordinates = [])
    split_chars_array = ship_coordinates.map{ |element|element.to_s.chars}
    @numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
    letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0}
    @con_letters = letter_array.flatten.uniq.count
    @con_numbers = @numbers_array.flatten.uniq.count
    @ord_letters = letter_array.map {|letter| letter.ord - 64}
    # # @count = coordinates.count #stored just to reference
    # If all of the conditionals below are true then its truly a valid placement. Code should breakout as soon as it hits false
    if ship_coordinates.count == ship.length
      if @con_letters == 1 && @con_numbers == ship.length
        index = 0
        if (ship.length - 1).times do
            @numbers_array[index + 1].to_i - @numbers_array[index].to_i != 1
            index += 1
          end
          return false # FALSE FOR LINE 51 FROM THIS LINE, WHEN THIS IS TRUE 51 WORKS BUT TEST LINES 46 AND 50 DO NOT
        else
          return true
        end
    elsif @con_letters = ship.length && @con_numbers == 1
      if @ord_letters.each do |num|
          index = 0
          @ord_letters[index + 1]- @ord_letters[index] == 1
          index += 1
          end
          return true
      else
        return false
      end
    else
      return false
    end
  else
    return false
  end
  end
end
# .zip method creates nested array to make coordinates
