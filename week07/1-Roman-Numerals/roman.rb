module Roman
  I = 1
  V = 5
  X = 10
  L = 50
  C = 100
  D = 500
  M = 1000

  def self.const_missing(name)
    digit_array = name.to_s.chars
    previous_digit = Roman.const_get(digit_array.shift.to_sym)
    arabic = 0

    digit_array.each do |digit|
      if previous_digit >= Roman.const_get(digit.to_sym)
        arabic += previous_digit
      else
        arabic -= previous_digit
      end
      previous_digit = Roman.const_get(digit.to_sym)
    end
    last_digit = Roman.const_get(digit_array.last.to_sym)
    arabic += last_digit
  end
end
