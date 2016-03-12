class InfinitePlane
  def initialize(x, y)
    @x, @y = x, y
  end

  def move_to_directions(directions)
    coeff = 1

    dx_moves = ['>', '<']
    dy_moves = ['^', 'v']

    moves = {
      '>' => 1,
      '<' => -1,
      '^' => -1,
      'v' => 1,
      '~' => 0
    }

    directions.chars.each do |direction|
      coeff *= -1 if direction == '~'
      step = moves[direction] * coeff

      if dx_moves.include? direction
        @x += step
      else
        @y += step
      end
    end
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

plane = InfinitePlane.new 0, 0
plane.move_to_directions '>>><<<~>>>~^^^'

puts plane
#class InfinitePlane
#  def initialize(x, y)
#    @x, @y= x, y
#  end
#
#  def move_to_directions(directions)
#    count = directions.count '~'
#    directions = directions.split('')
#    directions.each do |dir|
#      if dir == '~'
#        @x *= -1
#        @y *= -1
#      end
#      @x += 1 if dir == '>'
#      @x -= 1 if dir == '<'
#      @y += 1 if dir == 'v'
#      @y -= 1 if dir == '^'
#    end
#
#    if count.odd?
#      @x *= -1
#      @y *= -1
#    end
#  end
#
#  def to_array
#    [@x, @y]
#  end
#end

