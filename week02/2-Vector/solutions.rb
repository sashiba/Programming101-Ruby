class InfinitePlane
	def initialize(x, y)
		@x, @y= x, y
	end

	def move_to_directions(directions)
		#s hash
		change = false
		count = directions.count '~'
		directions = directions.split('') #chars
		directions.each do |dir|
			if dir == '~'
				@x *= -1
				@y *= -1
			end
			@x += 1 if dir == '>'
			@x -= 1 if dir == '<'
			@y += 1 if dir == 'v'
			@y -= 1 if dir == '^'
		end
		if count.odd?
			@x *= -1
			@y *= -1
		end
	end
	def to_array
		[@x, @y]
	end
end




class Vector2D
  def initialize(x, y)
    @x, @y = x, y
  end

  def x
  	@x
  end

  def x=(value)
  	@x = value
  end

  def y
  	@y
  end

  def y=(value)
  	@y = value
  end

  def length
    # v1 = (x,0)
    # v2 = (0,y)
    ((@x ** 2) + (@y ** 2)) ** (1/2.to_f)
  end

  def normalize
    @x = @x / length
    @y = @y / length
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def +(other)
    # Return a new Vector2D that represents the result
    Vector2D.new @x + other.x, @y + other.y
  end

  def -(other)
    # Return a new Vector2D that represents the result
    Vector2D.new @x - other.x, @y - other.y
  end

  def *(scalar)
    # Return a new Vector2D that represents the result
    Vector2D.new @x * scalar, @y * scalar
  end

  def /(scalar)
    # Return a new Vector2D that represents the result
    Vector2D.new @x / scalar, @y / scalar
    # to_f 
  end

  def dot(other)
    # Return the dot product of the two vectors
    # https://en.wikipedia.org/wiki/Dot_product#Algebraic_definition
    @x * other.x + @y * other.y
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

class Vector
  def initialize(*components)
    # Let's make it more interesting here. I wanna initialize the vector with
    # `Vector.new(1, 2, 3, 4)` and `Vector.new([1, 2, 3, 4])` and expect the same vector.
    @vector = []
    if components.size == 1
			components[0].each { |arg| @vector << arg }
		else
    	components.each { |arg| @vector << arg }
    end
  end

  def dimension
    @vector.size
  end

  def length
    l = 0
    @vector.each { |coord| l += coord ** 2 }
    l ** (1/2.to_f)
  end

  def normalize
    #@vector.map! { |coord| coord = coord / length }
  	@vector = @vector.map { |coord| coord = coord / length }
  
  end

  def [](index)
    @vector[index]
  end

  def []=(index, value)
    @vector[index] = value
  end

  def ==(other)
    if dimension != other.dimension
    	false
    else
    	b = true
    	@vector.each_index { |i| b = false if @vector[i] != other[i] }
  		b
  	end
  end

  def +(vector_of_same_dimension_or_scalar)
  	if vector_of_same_dimension_or_scalar.class != Array 
  		Vector.new (@vector.map { |coord| coord += vector_of_same_dimension_or_scalar })
  	elsif dimension == vector_of_same_dimension_or_scalar.size
  		new_vector = []
  		@vector.each_index { |i| new_vector << @vector[i] + vector_of_same_dimension_or_scalar[i] }
  		Vector.new new_vector
  	end
  end

  def -(vector_of_same_dimension_or_scalar)
    if vector_of_same_dimension_or_scalar.class != Array 
  		Vector.new (@vector.map { |coord| coord -= vector_of_same_dimension_or_scalar })
  	elsif dimension == vector_of_same_dimension_or_scalar.size
  		new_vector = []
  		@vector.each_index { |i| new_vector << @vector[i] - vector_of_same_dimension_or_scalar[i] }
  		Vector.new new_vector
  	end
  end

  def *(scalar)
 		Vector.new (@vector.map { |coord| coord = coord * scalar })
  end

  def /(scalar)
  	Vector.new (@vector.map { |coord| coord = coord / scalar.to_f })
  end

  def dot(vector_of_same_dimension_or_scalar)
    #@x * other.x + @y * other.y
    result = 0
    @vector.each_index { |i| result += @vector[i] * vector_of_same_dimension_or_scalar[i] }
    result
  end

  def to_s
    # Your code goes here.
    #"#{@vector.each { |c| c }}"
    "#{@vector}"
  end
end

















