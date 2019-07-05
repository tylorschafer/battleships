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

  def check_coordinates_against_length(ship, ship_coordinates = [])
    ship_coordinates.count == ship.length
  end

  def split_coordinates_to_individual_arrays(ship_coordinates = [])
    split_chars_array = ship_coordinates.map{ |element|element.chars}
    numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
    letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0}
    @uniq_letters = letter_array.flatten.uniq
    @uniq_numbers = numbers_array.flatten.uniq
    @ord_letters = @uniq_letters.map {|letter| letter.ord - 64}
  end

  def consecutive_numbers(ship)
    @uniq_letters == 1 && @uniq_numbers == ship.length
  end

  def consecutive_letters(ship)
    @uniq_letters == ship.length && @uniq_numbers == 1
  end

  def valid_placement?(ship, ship_coordinates = [])
    if check_coordinates_against_length(ship, ship_coordinates) == true
      if consecutive_numbers(ship) == true
        (ship.length - 1).times do
          index = 0
          if @uniq_numbers[index + 1].to_i - @uniq_numbers[index].to_i == 1
            return true
          else
            return false
            break
          end
          index += 1
        end
      elsif consecutive_letters(ship) == true
        (ship.length - 1).times do
          index = 0
          if @ord_letters[index + 1] - @ord_letters[index] == 1
            return true
          else
            return false
            break
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
