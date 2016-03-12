def fact(n)
  return 1 if n == 0
  1.upto(n).reduce(:*)
end

def nth_lucas(n)
  a, b = 2, 1

  2.upto(n) do
    a, b = b, a + b
  end

  a
end

def first_lucas(n)
  1.upto(n).map { |index| nth_lucas index }
end

def count_digits(n)
  n.to_s.chars.map(&:to_i).length
end

def sum_digits(n)
  n.to_s.chars.map(&:to_i).reduce(&:+)
end

def factorial_digits(n)
  n.to_s.chars.map(&:to_i).map { |d| fact d }.reduce(&:+)
end

def fib(n)
  return 1 if n == 1
  return 1 if n == 2

  fib(n - 1) + fib(n - 2)
end

def fib_number(n)
  a, b = 1, 1
  result = [a]
  2.upto(n) do
    a, b = b, a + b
    result << a
  end

  result.join('').to_i
end

def hack?(n)
  n.to_s(2).count('1').odd? && n.to_s(2).reverse == n.to_s(2)
end

def next_hack(n)
  n = n.next
  n = n.next until hack? n

  n
end

def count_vowels(str)
  vowels = ['A', 'E', 'I', 'O', 'U', 'Y']
  str.upcase.chars.select { |c| vowels.include? c }.length
end

def count_consonants(str)
  consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm',
                'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z']

  str.downcase.chars.select { |c| consonants.include? c }.length
end

def p_score(n)
  return 1 if palindrome? n

  1 + p_score(n + n.to_s.reverse.to_i)
end

def palindrome?(n)
  n.to_s.reverse == n.to_s
end

def largest_palindrome(n)
  return n if palindrome?(n)

  largest_palindrome(n - 1)
end

def prime?(n)
  return false if n <= 1
  2.upto(n) do |cur|
    return true if cur == n
    return false if n % cur == 0
  end

  true
end

def first_primes(n)
  list = []
  current = 1
  while current <= n do
    list << current if prime? current
    n += 1 unless prime? current
    current += 1
  end

  list
end

def sieve_of_eratosthenes(n)
  numbers = []
  2.upto(n) { |i| numbers << i }
  cur = 2

  2.upto(n) do |i|
    i.upto(n) { |j| numbers.delete(cur * j) } if prime? cur
    cur += 1
  end

  numbers
end

def char_is_positive_digit?(n)
  123_456_789_0.to_s.chars.include? n
end

def sum_of_numbers_in_string(str)
  result = 0
  number = ''
  str.chars.each do |char|
    number += char if char_is_positive_digit? char
    unless char_is_positive_digit? char
      result += number.to_i
      number = ''
    end
  end

  result += number.to_i
end

def anagrams?(a, b)
  a.chars.sort == b.chars.sort
end

def anagram_of?(a, b)
  return false if a.length > b.length
  b.split.each do |word|
    return false unless anagrams?(a, word)
  end

  true
end

def balanced?(n)
  n = n.to_s
  mid = n.length / 2

  left = n.slice(0, mid).to_i
  right = n.slice(mid + n.length % 2, n.length).to_i

  sum_digits(left) == sum_digits(right)
end

def zero_insert(n)
  result = n.to_s[0]
  n = n.to_s.slice(1, n.to_s.length)
  j = 0
  n.each_char do |digit|
    if (result[j] == digit) || (result[j].to_i + digit.to_i) % 10 == 0
      result += '0' + digit
      j += 2
    else
      result += digit
      j += 1
    end
  end

  result.to_i
end
