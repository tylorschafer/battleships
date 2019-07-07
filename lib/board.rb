class Board
  attr_reader :coordinates, :cells

  def initialize
    @coordinates = Coordinates.new.run
    @cells = create_cells
  end

  def create_cells
    new_board = Hash.new
    @coordinates.each do |coord|
      new_board[coord] = Cell.new(coord)
    end
    new_board
  end

  def valid_coordinate?(coord)
    @coordinates.include?(coord)
  end

  def coordinate_count_equal_to_length?(ship, ship_coordinates = [])
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
    if coordinate_count_equal_to_length?(ship, ship_coordinates) && overlapping_ships?(ship_coordinates) && (consecutive_letters?(ship) || consecutive_numbers?(ship))
      return true
    else
      false
    end
  end

  def place(ship, ship_coordinates)
    if valid_placement?(ship, ship_coordinates)
      ship_coordinates.each {|coord| @cells[coord].place_ship(ship)}
    else
      return false
    end
  end

  def overlapping_ships?(ship_coordinates)
    ship_coordinates.all? {|coord| @cells[coord].empty?}
  end

  def render(show = false)
    uniq_number_cells = @cells.collect {|key,value| key.chars[1].to_i}.uniq
    uniq_letter_cells = @cells.collect {|key, value| key.chars[0]}.uniq
    num = 0
    @rendered_board = @cells.collect do |key,value|
      if key.chars[1].to_i == uniq_number_cells.count
        num += 1
        "#{value.render} \n"
      elsif key.chars[1].to_i == 1 && value.empty? == true
        "#{uniq_letter_cells[num]} #{value.render}"
      elsif key.chars[1].to_i == 1 && value.empty? == false
        "#{uniq_letter_cells[num]} #{value.render(true)}"
      elsif show == true && value.empty? == false
        "#{value.render(true)}"
      else
        "#{value.render}"
      end
    end
    "  #{uniq_number_cells.join(" ")} \n #{@rendered_board.join(" ")}"
  end
end
