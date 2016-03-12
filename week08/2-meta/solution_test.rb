require 'minitest/autorun'

require_relative 'solution'

@@test_class_variable = 'test_class_variable_in_obj'

class SolutionTest < Minitest::Test
  def test_the_truth
    obj = Object.new
    obj.define_singleton_method(:foo) { 42 }

    assert_equal 42, obj.foo
  end

  def test_module_cattr_accessor_default_value
    Object.class_eval do
      cattr_accessor :test_class_variable
      cattr_accessor(:class_variable_with_def_val) { [] }
    end

    assert_equal [], Object.class_variable_with_def_val
  end

  def test_module_cattr_reader
    Object.class_eval { cattr_reader :test_class_variable }

    assert_equal Object.test_class_variable, 'test_class_variable_in_obj'
  end

  def test_module_cattr_writer_in_object
    Object.class_eval do
      cattr_writer :test_class_variable
      cattr_reader :test_class_variable
    end
    Object.test_class_variable = 'test'

    assert_equal Object.test_class_variable, 'test'
  end
end
