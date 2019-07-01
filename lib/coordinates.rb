require 'pry'

class Coordinates
  attr_reader :x, :y, :y_array, :x_array

  def initialize(x = 4, y = 4)
    @x = x
    @y = y
    @x_array = []
    @y_array = []
  end

  def to_letter
    (64 + @x).chr
  end

  def y_loader
    number = 0
    until number > @y
      @y_array << number
      number += 1
    end
    @y_array
  end
binding.pry

end
