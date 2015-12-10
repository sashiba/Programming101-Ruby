class Board
  include Enumerable
    
  def initialize(*cells)
    @cells = cells    
  end

  def each(&block)
    @cells.each(&block)
  end

  def neighbours(member)
    x, y = member
    neighbours = [
      [x - 1, y],
      [x + 1, y],
      [x, y - 1],
      [x, y + 1],
      [x - 1, y + 1],
      [x + 1, y + 1],
      [x - 1, y - 1],
      [x + 1, y - 1]
    ]
  end

  def [](x, y)
    include? [x, y]
  end

  def revive(member)
    count_live_neighbours(member) == 3
  end

  def count_live_neighbours(cell)
    neighbours(cell).select { |neighbour| include?(neighbour) }.size
  end

  def live_cells
    select { |cell| (2..3).include? count_live_neighbours(cell) }
  end

  def <<(other)
    @cells << other unless @cells.include? other
  end

  def count
    @cells.size
  end

  def next_generation
    Board.new.tap do |next_gen|
      @cells.each do |cell|
      end
    end
  end

end