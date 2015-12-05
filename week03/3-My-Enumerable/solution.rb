module MyEnumerable
#bundle exec rake test

  def map
    Array.new.tap do |arr|
      each { |element| arr << (yield element) }
    end
  end

  def filter
    Array.new.tap do |arr|
      each { |element| arr << element if yield element }
    end
  end

  def negate_block(&block)
    Proc.new { |x| !block.call(x) }
  end

  def reject
    Array.new.tap do |arr| 
     each { |element| arr << element unless (yield element) }
    end
    #filter(negate_block(&block))
  end

  def reduce(initial = nil)
    each do |element|
      if initial == nil
        initial = element
      else
        initial = yield(initial, element)
      end
    end
    initial
  end

  def any?(&block)
    filter(&block).size > 0
  end

  def all?(&block)
    filter(&block).size == size
  end

  def one?(&block)
    filter(&block).size == 1
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
    any?{ |elem| elem == element }
  end

  def each_cons(n)
    result, count = [], 0
    each do |element| 
      if count == n - 1
        yield result
        result, count = [], 0
      elsif count < n - 1
        result << element
        count += 1
      end
    end
  end

  def count(element = nil)
    return size if element == nil
    filter { |x| x == element }.size
  end

  def size
    map { |x| 1 }.reduce(0) { |acc, x| acc + x }
  end

  def group_by
    Hash.new([]).tap do |hash|
      each do |element|
        result = []
        result << hash[yield i]
        if hash.key?(yield i)
          result << i
          hash[yield element] = result
        else
          hash[yield element] = i
        end
      end
    end
  end

  def min
    reduce { |min, element| min > element ? element : min }
    #if block.given?
  end

  def min_by
    reduce { |min, element| (yield min) > (yield element) ? element : min }
    #each { |element| min = element if (yield min) > (yield element) }
  end

  def max
    reduce { |max, element| max < element ? element : max }
  end

  def max_by
    reduce{ |max, element| (yield max) < (yield element) ? element : max }
    #each { |element| max = element if (yield max) < (yield element) }
  end

  def take(n)
    Array.new.tap do |arr|
      counter = 0
      each do |element|
        arr << element if counter < n
        counter += 1
      end
    end
  end

  def take_while
    Array.new.tap do |arr|
      each do |element|
        arr << element if (yield element)
        break      unless (yield element)        
      end
    end
  end

  def drop(n)
    Array.new.tap do |arr|
      counter = 1
      each do |element|
        arr << element if counter > n
        counter += 1
      end
    end
  end
#oprai
  def drop_while
    counter, arr, b = 0, [], true
    each do |element|
      arr << element
      if (yield element) and b
        counter += 1 
      else
        b = false
      end   
    end
    arr.drop(counter) 
  end
  alias_method :collect, :map
  alias_method :select,  :filter
  alias_method :foldl,   :reduce
end