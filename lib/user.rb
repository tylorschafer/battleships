class User
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @board.create_cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def cruiser_placement
    # Iteration over this until uder provides valid coordinates
    puts 'Enter the squares for the Cruiser (3 spaces):'
    selection = gets.chomp
    selection_array = selection.split(" ")
    if @board.valid_placement?(@cruiser, selection_array)
      @board.place(@cruiser, selection_array)
      @board.render(true)
      return true
    else
      puts "Those are invalid coordinates. Please try again:"
    end
  end
end
