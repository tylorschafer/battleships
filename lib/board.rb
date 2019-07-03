
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

  def consecutive_placement(array = [])
    chars_array = array.map{ |element|element.to_s.chars}
    numbers_array = chars_array.flatten.find_all{ |char|char.to_i != 0}
    letter_array = chars_array.flatten.find_all{ |char|char.to_i == 0}
    @count = numbers_array.count
    @first_num = numbers_array.first.to_i
    @last_num = numbers_array.last.to_i
    @first_letter = letter_array.first.ord
    @last_letter = letter_array.last.ord
    @letter_sum = letter_array.ord.sum - 64
    if (@count == 5) && (@last_num - @first_num <= 4) && (@last_letter - @first_letter <= 1)
        true
      elsif (@count == 4) && (@last_num - @first_num) <= 3 && (@last_letter - @first_letter <= 1)
        true
      elsif (@count == 3) && (@last_num - @first_num) <= 2 && (@last_letter - @first_letter <= 1)
        true
      elsif (@count == 2) && (@last_num - @first_num <= 1) && (@last_letter - @first_letter <= 1)
        true
      else
        false
    end
  end


  def validate_coordinate?(coord)
    @cells.keys.include?(coord)
  end


  def valid_placement?(ship, coordinates = [])
    if (coordinates.count == ship.health) && (consecutive_placement(coordinates) == true)
      true
    else
      false
    end
  end
end
