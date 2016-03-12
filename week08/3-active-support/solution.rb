class Object
  def blank?
    return true unless self
    return delete(' ').empty? if instance_of? String
    empty? if respond_to? :empty?
  end

  def present?
    !blank?
  end

  def presence
    self if present?
  end

  def try(method = nil, &block)
    return public_send(method) if method && respond_to?(method)

    instance_eval(&block) if block_given? && !nil?
  end
end

class String
  def inquiry
  end
end

class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  attr_accessor :first_name, :last_name
end
