class Cell

  attr_reader :coordinate, :cell_contents, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @cell_contents = []
    @fired_upon = false
    @ship = ship
  end


  def empty?
    if @cell_contents.empty?
      true
    else
      false
    end
  end

  def place_ship(ship)
    @cell_contents << ship
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    @ship.hit
  end

  def fired_upon?
    @fired_upon
  end

  def render(show = false)
    if @fired_upon == true && @cell_contents.empty? == false
      "H"
    elsif @fired_upon == true && @ship.sunk? == true
      "X"
    elsif @fired_upon == true && @cell_contents.empty == true
      "M"
    elsif show == true
      "S"
    end
  end

end
