class Board
  attr_reader :coordinates, :cells

  def initialize(length = 9, width = 9)
    @length = length
    @width = width
    @coordinates = Coordinates.new(length, width).run
    @cells = create_cells
  end

  def create_cells
    new_board = Hash.new
    @coordinates.each do |coord|
      new_board[coord] = Cell.new(coord)
    end
    new_board
  end

  def valid_coordinate?(*coordinates)
    coordinates.all? {|single_coord| @coordinates.include?(single_coord)}
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
      second.to_i - first.to_i == 1 || second.to_i - first.to_i == -1
    end
  end

  def consecutive_letters?(ship)
    if @uniq_letters.count != ship.length || @uniq_numbers.count != 1
      return false
    end
    @uniq_letters.each_cons(2).all? do |first, second|
      second - first == 1 || second - first == -1
    end
  end

  def valid_placement?(ship, ship_coordinates)
      create_uniq_letters(ship_coordinates)
      create_uniq_numbers(ship_coordinates)
      return coordinate_count_equal_to_length?(ship, ship_coordinates) && overlapping_ships?(ship_coordinates) && (consecutive_letters?(ship) || consecutive_numbers?(ship))
  end

  def place(ship, ship_coordinates)
    if valid_placement?(ship, ship_coordinates)
      ship_coordinates.each {|coord| @cells[coord].place_ship(ship)}
    else
      return false
    end
  end

  def overlapping_ships?(ship_coordinates)
    if ship_coordinates.all? {|single_coord| @coordinates.include?(single_coord)} == true
      ship_coordinates.all? {|coord| @cells[coord].empty?}
    end
  end

  def render(show = false)
    uniq_number_cells = @cells.collect {|key,value| key.chars[1].to_i}.uniq
    @grouped_cells = @cells.group_by {|cell| cell[0][0]}
    if show == true
      @formatted_board = @grouped_cells.map do |key,value|
        "#{key} #{value.map {|cell| cell[1].render(true) + " "}.join}"
      end
    elsif show == false
      @formatted_board = @grouped_cells.map do |key,value|
        "#{key} #{value.map {|cell| cell[1].render + " "}.join}"
      end
    end
    @final_board = @formatted_board.map do |line|
      line + "\n"
    end
    @output = "   #{uniq_number_cells.join(" ")} \n #{@final_board.join(" ")}"
    puts @output
    @output
  end
end
