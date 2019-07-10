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
    if @cell_contents.empty? == false
      @ship.hit
    end
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(show = false)
    if @cell_contents.empty? == false && show == true && @fired_upon == false
      "S"
    elsif @fired_upon == true && @cell_contents.empty? == true
      "M"
    elsif @cell_contents.empty? == false && @ship.sunk? == true
      "X"
    elsif @fired_upon == true && @cell_contents.empty? == false
      "H"
    else
      "."
    end
  end
end
