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
    split_chars_array = ship_coordinates.map{ |element|element.chars}
    numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
    letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0}
    @uniq_letters = letter_array.flatten.uniq
    @uniq_numbers = numbers_array.flatten.uniq
    @ord_letters = letter_array.map {|letter| letter.ord - 64}
    if ship_coordinates.count == ship.length
      if @uniq_letters == 1 && @uniq_numbers == ship.length
        index = 0
        (ship.length - 1).times do
          if @uniq_numbers[index + 1].to_i - @uniq_numbers[index].to_i == 1
            return true
          else
            return false
          end
          index += 1
        end
      elsif @uniq_letters == ship.length && @uniq_numbers == 1
        index = 0
        (ship.length - 1).times do
          if @ord_letters[index + 1] - @ord_letters[index] == 1
            return true
          else
            return false
          end
          index += 1
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
