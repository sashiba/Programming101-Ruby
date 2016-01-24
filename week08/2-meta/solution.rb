class Object
  def define_singleton_method(name, method = nil, &block)
  end

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

  def define_singleton_method_v1(symbol, method = nil, &block)
    # self.instance_eval
    singleton_class.class_eval { define_method(symbol, method) } if method
    singleton_class.class_eval { define_method(symbol, &block) } if block_given?
  end
end

class String
  # def decompose
  #   methods = []
  #   chars = self.chars
  #   while chars.include? '.'
  #     methods << chars.take_while { |c| c != '.' }.join
  #     chars = chars.drop_while { |c| c != '.' }.drop(1)
  #   end
  #   methods << chars.join if chars

  #   methods
  # end

  # def to_proc
  #   # proc { |arg, args*| arg.send(self, *args) }
  #   methods = self.decompose
  #   p methods
  #   methods.each do |method|
  #     lambda { |x, *args| x.public_send method.to_sym, *args }
  #   end

  #   #lambda { |x, *args| x.public_send self, *args }
  # end
  def to_proc
    proc { |arg, *args| arg.public_send(self, *args) }
  end
end

class Module
  def private_attr_accessor(*attrs)
  end

  def cattr_accessor(*attrs, &block)
    attrs.each do |attr|
      class_variable_set("@@#{attr}", yield) if block_given?
      cattr_reader attr
      cattr_writer attr
    end
  end

  def cattr_reader(*attrs)
    attrs.each do |attr|
      define_singleton_method("#{attr}") { class_variable_get("@@#{attr}") }
    end
  end

  def cattr_writer(*attrs)
    attrs.each do |attr|
      define_singleton_method("#{attr}=") do |value|
        class_variable_set("@@#{attr}", value)
      end
    end
  end
end

class Nilclass
end

class TestClass
  @@class_variable = 'class variable'
  def define_singleton_method(name, method = nil, &block)
  end
end
