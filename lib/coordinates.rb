
class Coordinates
  attr_reader :x, :y, :x_array, :y_array, :coords

  def initialize(x = 4, y = 4)
    @x = x
    @y = y
    @x_array = []
    @y_array = []
    @coords = []
  end

  def to_letter
    (64 + @x).chr
  end

  def y_loader
    num = 1
    until num > @y do
      @y_array << num.to_s
      num += 1
    end
    @y_array
  end

  def x_loader
    num = 1
    until num > @x do
      @x_array << (64 + num).chr
      num += 1
    end
    @x_array
  end

  def add_x_and_y
    @x_array.each do |letter|
      index = 0
      @coords << @x_array[index] + @y_array[index]
      index += 1
    end
    @coords
  end
end
