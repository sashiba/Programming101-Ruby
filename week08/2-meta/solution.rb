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

  def define_singleton_method_v1(symbol, method = nil, &block)
    # self.instance_eval
    singleton_class.class_eval { define_method(symbol, method) } if method
    singleton_class.class_eval { define_method(symbol, &block) } if block_given?
  end

  def delegate(method_name, to:)
    class_eval <<-RUBY
      def #{method_name}(*args, &block)
        #{to}.#{method_name}(*args, &block)
      end
    RUBY
    # define_method method_name do |*args, **kw, &block|
    # end
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
*
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
    attrs.each do |attr|
      
    end
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

class Proxy
  def initialize(*object)
    @object = object.flatten
  end

  def method_missing(method_name, *args)
    @object.send(method_name, *args)
  end

  def respond_to_missing?(method_name, *args)
    @object.respond_to?(method_name)
  end
end

class Nilclass
  def method_missing(*)
    nil
  end

  def respond_to_missing?(*)
    nil
  end
end
