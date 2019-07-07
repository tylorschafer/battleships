class User
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @board.create_cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def cruiser_placement
    @board.render(true)
    valid_input = false
    until valid_input == true do
      puts 'Enter the squares for the Cruiser (3 spaces):'
      selection = gets.chomp.upcase
      selection_array = selection.split(" ")
      if @board.valid_placement?(@cruiser, selection_array)
        @board.place(@cruiser, selection_array)
        @board.render(true)
        valid_input = true
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
    valid_input
  end

  def submarine_placement
    @board.render(true)
    valid_input = false
    until valid_input == true do
      puts 'Enter the squares for the Submarine (2 spaces):'
      selection = gets.chomp.upcase
      selection_array = selection.split(" ")
      if @board.valid_placement?(@submarine, selection_array)
        @board.place(@submarine, selection_array)
        @board.render(true)
        valid_input = true
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
    valid_input
  end
end
