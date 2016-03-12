class Hash

  def pick1(*keys)
    Hash.new.tap do |h|
      each { |k, v| h[k] = v if keys.include? k } 
    end
  end
  
  def pick(*keys)
    hash = {}
    each { |key, value| hash[key] = value if keys.include? key }
    hash
    # select {|k,v| keys.include? k }
  end

  def pick!(*keys)
    select! { |key, value| keys.include? key }
  end

  def except(*keys)
    Hash.new.tap do |hash|
      each { |key, value| hash[key] = value unless keys.include? key }
    end
  end

  def except!(*keys)
    reject! { |k, v| keys.include? k }
  end

  def compact_values
    select { |k, v| v}
    #each { |key, value| hash[key] = value if (value != false and value != nil) }
  end

  def compact_values!
    select! { |k, v| v }
  end

  def defaults(hash)
    Hash.new.tap do |h|
      each { |k, v| h[k] = v }
      hash.each { |k, v| h[k] = v if h[k] == nil }
    end    
  end

  def defaults!(hash)
    hash.each do |key, value|
      self[key] = value if self[key] == nil
    end

    self
  end

end


