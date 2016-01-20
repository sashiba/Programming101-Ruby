class Object
  def singleton_class_v1
    raise TypeError, "can't define singleton" if self.class == Symbol && self.class == Fixnum
    case self
    when true
      TrueClass
    when false
      FalseClass
    when nil
      NilClass
    else
      class << self
        self
      end
    end
  end

  def define_singleton_method_v1(symbol, method, &block)
    class << self
      define_method(symbol.to_sym, instance_method(:method))
    end
  end
end
