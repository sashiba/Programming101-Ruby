class NumberSet
  include Enumerable

  def each(&block)
    @numbers.each(&block)
  end

  def initialize(numbers = [])
    @numbers = numbers
  end

  def <<(other)
    @numbers << other unless @numbers.include? other
  end

  def size
    @numbers.size
  end

  def empty?
    size == 0
  end

  def [](filter)
    NumberSet.new @numbers.select { |number| filter.matches? (number) }
  end
end

module FilterOperators
  def &(other)
    Filter.new { |number| matches?(number) and other.matches?(number) }
  end

  def |(other)
    Filter.new { |number| matches?(number) or other.matches?(number) }
  end

  def matches?(number)
    @filter.call number
  end
end

class Filter
  include FilterOperators

  def initialize(&block)
    @filter = block
  end

end

class TypeFilter
  include FilterOperators

  def initialize(type)
    @filter = case type
              when :integer then Proc.new { |number| number.is_a? Integer }
              when :real    then Proc.new { |number| (number.is_a? Float) ||
                                                     (number.is_a? Rational) }
              when :complex then Proc.new { |number| number.is_a? Complex }
              end
  end

end

class SignFilter
  include FilterOperators

  def initialize(sign)
    @filter = case sign
              when :positive     then Proc.new { |number| number > 0 }
              when :non_positive then Proc.new { |number| number <= 0 }
              when :negative     then Proc.new { |number| number < 0 }
              when :non_negative then Proc.new { |number| number >= 0 }
              end
  end
end
