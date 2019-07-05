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

  def create_uniq_numbers(ship_coordinates)
    split_chars_array = ship_coordinates.map{ |element|element.chars}
    numbers_array = split_chars_array.flatten.find_all{ |char|char.to_i != 0}
    @uniq_numbers = numbers_array.flatten.uniq
  end

  def create_uniq_letters(ship_coordinates)
    split_chars_array = ship_coordinates.map{ |element|element.chars}
    letter_array = split_chars_array.flatten.find_all{ |char|char.to_i == 0}
    uniq_letters = letter_array.flatten.uniq
    @uniq_letters = uniq_letters.map {|letter| letter.ord - 64}
  end

  def consecutive_numbers?(ship)
    if @uniq_letters.count != 1 || @uniq_numbers.count != ship.length
      return false
    end
    @uniq_numbers.each_cons(2).all? do |first, second|
      second.to_i - first.to_i == 1
    end
  end

  def consecutive_letters?(ship)
    if @uniq_letters.count != ship.length || @uniq_numbers.count != 1
      return false
    end
    @uniq_letters.each_cons(2).all? do |first, second|
      second - first == 1
    end
  end

  def valid_placement?(ship, ship_coordinates)
    create_uniq_letters(ship_coordinates)
    create_uniq_numbers(ship_coordinates)
    if check_coordinates_against_length(ship, ship_coordinates) && (consecutive_letters?(ship) || consecutive_numbers?(ship))
      return true
    else
      false
    end
  end
end
# .zip method creates nested array to make coordinates
