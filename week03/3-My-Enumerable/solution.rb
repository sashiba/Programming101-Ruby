module MyEnumerable
#bundle exec rake test

  def map
    return enum_for(:map) unless block_given?
    [].tap do |arr|
      each { |element| arr << (yield element) }
    end
  end

  def filter
    return enum_for(:filter) unless block_given?
    [].tap do |arr|
      each { |element| arr << element if yield element }
    end
  end

  def negate_block(&block)
    Proc.new { |x| !block.call(x) }
  end

  def reject
    return enum_for(:reject) unless block_given?
    [].tap do |arr| 
     each { |element| arr << element unless (yield element) }
    end
    #filter(negate_block(&block))
  end

  def reduce(initial = nil)
    return enum_for(:reduce) unless block_given?
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
    return enum_for(:any?) unless block_given?
    filter(&block).size > 0
  end

  def all?(&block)
    return enum_for(:all?) unless block_given?
    filter(&block).size == size
  end

  def one?(&block)
    return enum_for(:one?) unless block_given?
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

  #def reject(&block)
  #  filter(negate_block(&block))
  #end

  def size
    map { |x| 1 }.reduce(0) { |acc, x| acc + x }
  end

  def include?(element)
    any?{ |elem| elem == element }
  end

  def each_cons(n)
    return enum_for(:each_cons) unless block_given?
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

  def group_by
    return enum_for(:group_by) unless block_given?
    
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
    return enum_for(:min_by) unless block_given?

    reduce { |min, element| (yield min) > (yield element) ? element : min }
    #each { |element| min = element if (yield min) > (yield element) }
  end

  def max
    reduce { |max, element| max < element ? element : max }
  end

  def max_by
    return enum_for(:max_by) unless block_given?
    
    reduce{ |max, element| (yield max) < (yield element) ? element : max }
    #each { |element| max = element if (yield max) < (yield element) }
  end

  def take(n)
    [].tap do |arr|
      counter = 0
      each do |element|
        arr << element if counter < n
        counter += 1
      end
    end
  end

  def take_while
    return enum_for(:take_while) unless block_given?
    
    [].tap do |arr|
      each do |element|
        arr << element if (yield element)
        break      unless (yield element)        
      end
    end
  end

  def drop(n)
    [].tap do |arr|
      counter = 1
      each do |element|
        arr << element if counter > n
        counter += 1
      end
    end
  end
#oprai
  def drop_while
    return enum_for(:drop_while) unless block_given?
    
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