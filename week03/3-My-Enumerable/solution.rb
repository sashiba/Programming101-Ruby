# Implementation of our own Enumerable class
module MyEnumerable
  def map
    Array.new.tap do |arr|
      each do |element|
        value = yield element
        arr << value
      end
    end
  end

  def filter
    Array.new.tap do |arr|
      each do |element|
        arr << element if (yield element)
      end
    end
  end

  def first
    element = nil

    each do |x|
      element = x
      break
    end

    element
  end

  def reduce(initial = nil)
    skip_first = false

    if initial.nil?
      initial = first
      skip_first = true
    end

    each do |x|
      if skip_first
        skip_first = false
        next
      end
      initial = yield initial, x
    end

    initial
  end

  def negate_block(&block)
    Proc.new { |x| !block.call(x) }
  end

  def reject(&block)
    filter(negate_block(&block))
  end

  def size
    map { |x| 1 }.reduce(0) { |acc, x| acc + x }
  end

  def any?(&block)
    filter(&block).size > 0
  end

  def all?(&block)
    filter(&block).size == size
  end

  def include?(element)
    # Your code goes here
  end

  def count(element = nil)
    if element.nil?
      return size
    end

    filter { |x| x == element }.size
  end


  def min
    # Your code goes here.
  end

  def min_by
    # Your code goes here.
  end

  def max
    # Your code goes here.
  end

  def max_by
    # Your code goes here.
  end

  def take(n)
    # Your code goes here.
  end

  def take_while
    # Your code goes here.
  end

  def drop(n)
    # Your code goes here.
  end

  def drop_while
    # Your code goes here.
  end
end

class Collection
  include MyEnumerable

  def initialize(*data)
    @data = data
  end

  def each(&block)
    @data.each(&block)
  end

  def ==(otherCollection)
    @data == otherCollection.data
  end

  def get(index)
    return @data[index]
  end
end

