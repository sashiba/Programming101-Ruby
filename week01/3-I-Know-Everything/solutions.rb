def numbers_to_message(pressed_sequence)
  result = ''
  upcase = false

  while pressed_sequence.size > 0
    current = pressed_sequence[0]
    count_current = pressed_sequence.take_while { |d| current == d }.size
    pressed_sequence = pressed_sequence.drop_while { |d| current == d }
    if current == 0
      result += ' '
    elsif current == 1
      upcase = true
    else
      result += convert_to_letter(current, count_current) unless upcase
      if upcase
        result += convert_to_letter(current, count_current).upcase
        upcase = false
      end
    end
  end

  result
end

def convert_to_letter(digit, count)
  letter = ''
  hash = { 2 => ['c', 'a', 'b'],
           3 => ['f', 'd', 'e'],
           4 => ['i', 'g', 'h'],
           5 => ['l', 'k', 'j'],
           6 => ['o', 'm', 'n'],
           7 => ['s', 'p', 'q', 'r'],
           8 => ['v', 't', 'u'],
           9 => ['z', 'w', 'x', 'y'] }
  case digit
  when 2..6, 8 then letter = hash[digit][count % 3]
  when 7, 9    then letter = hash[digit][count % 4]
  end

  letter
end

def message_to_numbers(message)
  result = []
  message = message.split('')
  message.each do |letter|
    if letter == ' '
      result += [0]
    elsif letter_to_number(letter) == []
      result += [1] + letter_to_number(letter.downcase)
    elsif result[result.size - 1] == letter_to_number(letter)[0]
      result += [-1] + letter_to_number(letter)
    else
      result += letter_to_number(letter)
    end
  end

  result
end

def letter_to_number(letter)
  keyboard = [['a', 'b', 'c'],
              ['d', 'e', 'f'],
              ['g', 'h', 'i'],
              ['j', 'k', 'l'],
              ['m', 'n', 'o'],
              ['p', 'q', 'r', 's'],
              ['t', 'u', 'v'],
              ['w', 'x', 'y', 'z']]

  pressed, button_pressed, result = 0, 0, []
  keyboard.each_with_index do |button, i|
    if button.include?(letter)
      pressed = button.index(letter) + 1
      button_pressed = i + 2
    end
  end
  pressed.times { result << button_pressed }

  result
end

def prepare_meal(number)
  str, arr, n = '', [], 0

  1.upto(number**(1 / 3.to_f)) { |i| arr << 3**i }
  n = arr.select { |i| number % i == 0 }.max
  n **= (1 / 3.to_f) unless n.nil?
  n.to_i.times { str += 'spam ' }

  if number % 5 == 0 && str == ''
    str += 'eggs'
  elsif number % 5 == 0
    str += 'and eggs'
  end

  str = str.chop if str[str.length - 1] == ' '

  str
end

def reduce_file_path(path)
  reduced, str = [], ['/']
  path = path.split('/')
  path.delete('.')
  path.delete('')
  path.each do |i|
    if i == '..'
      str.delete_at(str.size - 1)
    else
      str << i + '/'
    end
  end

  reduced = str.join
  reduced = reduced.chop if reduced.size > 1
  reduced = '/'          if reduced.size == 0
  reduced
end

def an_bn?(word)
  a, b = '', ''
  if word.length.odd?
    false
  else
    n = word.length / 2
    1.upto(n) do
      a << 'a'
      b << 'b'
    end
  end
  word == a + b
end

def valid_credit_card?(number)
  sum = []
  if count_digits(number).even?
    false
  else
    number = number.to_s.reverse.split('')
    number.each_with_index do |d, i|
      if i.even?
        sum << d.to_i
      else
        sum << d.to_i * 2
      end
    end
  end

  (sum.reduce:+) % 10 == 0
end

def count_digits(n)
  n.to_s.split('').size
end

def sum_digits(n)
  n = n.to_s.split('')
  a = []
  n.each { |i| a << i.to_i }
  a.reduce:+
end

def prime?(n)
  return false if n <= 1
  2.upto(n) do |cur|
    return true if cur == n
    return false if n % cur == 0
  end

  true
end

def goldbach(n)
  primes = []
  1.upto(n) do |i|
    primes << i if prime?(i)
  end
  result = []
  primes.each do |i|
    result << [i, n - i] if primes.include?(n - i) && !result.include?([n - i, i])
  end

  result
end

def magic_square?(matrix)
  sum_r, sum_c, sum_d1, sum_d2, i = [], [], 0, 0, 0
  j = matrix.size - 1
  return false if matrix.size != matrix[0].size
  matrix.each do |row|
    sum_r << (row.reduce:+)
    sum_d1 += row[i]
    sum_d2 += row[j]
    j -= 1
    i += 1
  end

  matrix_t = transpose(matrix)
  matrix_t.each do |col|
    sum_c << (col.reduce:+)
  end

  b = sum_r.all? { |i| i == sum_r[0] }
  b1 = sum_c.all? { |i| i == sum_c[0] }
  b == b1 && sum_d1 == sum_d2 && sum_r[0] == sum_d1
end

def transpose(matrix)
  matrix.size.times do |i|
    0.upto(i) do |j|
      matrix[i][j], matrix [j][i] = matrix[j][i], matrix[i][j]
    end
  end
  matrix
end
