class Array
  def to_hash
    hash = {}
    self.each do |elem|
      hash[elem[0]] = elem[1]
    end
    hash
  end

  def index_by(&block)
    hash = {}
    self.each do |elem| 
      hash[block.call(elem)] = elem
    end
    hash
  end

  def subarray_count(subarray)
    count = 0
    self.each_with_index do |elem, i|
      count += 1 if elem == subarray[0] && self.slice(i, subarray.size) == subarray
    end
    count
  end

  def occurences_count
    hash = Hash.new(0)
    self.each do |elem|
      if hash.has_key?(elem)
        hash[elem] += 1
      else
        hash[elem] = 1
      end
    end
    hash
  end
end
