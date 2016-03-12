module GameOfLife
  class Board
    include Enumerable

    def initialize(*cells)
      @cells = cells.uniq
    end

    def each(&block)
      @cells.each(&block)
    end

    def neighbours(member)
      x, y = member
      neighbours = [ [x - 1, y + 1], [x, y + 1], [x + 1, y + 1],
                     [x - 1, y],                 [x + 1, y],
                     [x - 1, y - 1], [x, y - 1], [x + 1, y - 1]
      ]
    end

    def [](x, y)
      include? [x, y]
    end

    def revive_cell(cell_neighbours)
      [].tap do |revived_cells|
        cell_neighbours.each do |neighbour|
          revived_cells << neighbour if (count_alive_neighbours(neighbour) == 3) and !include?(neighbour)
        end
      end
    end

    def count_alive_neighbours(cell)
      neighbours(cell).select { |neighbour| include?(neighbour) }.size
    end

    def alive_cells
      select { |cell| (2..3).include? count_alive_neighbours(cell) }
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
          revive_cell(neighbours(cell)).each { |res| next_gen << res }
        end
        next_gen << alive_cells.flatten(1)
      end
    end
    
  end

end
