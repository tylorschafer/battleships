
class Board
  attr_reader :cells, :cell

  def initialize
    @cells = {
      :A1 => Cell.new(:A1),
      :A2 => Cell.new(:A2),
      :A3 => Cell.new(:A3),
      :A4 => Cell.new(:A4),
      :B1 => Cell.new(:B1),
      :B2 => Cell.new(:B2),
      :B3 => Cell.new(:B3),
      :B4 => Cell.new(:B4),
      :C1 => Cell.new(:C1),
      :C2 => Cell.new(:C2),
      :C3 => Cell.new(:C3),
      :C4 => Cell.new(:C4),
      :D1 => Cell.new(:D1),
      :D2 => Cell.new(:D2),
      :D3 => Cell.new(:D3),
      :D4 => Cell.new(:D4)
    }
    @cell = cell
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


  def validate_coordinate?(coord)
    @cells.keys.include?(coord)
  end

  def valid_placement?(ship, coordinates = [])
    if (coordinates.count == ship.health)
      true
    else
      false
    end
  end
end
