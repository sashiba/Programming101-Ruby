require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_the_truth
    assert true
  end

  def test_module_cattr_accessor_default_value
    TestClass.class_eval do
      cattr_accessor :class_variable
      cattr_accessor(:class_variable_with_def_val) { [] }
    end

    assert_equal [], TestClass.class_variable_with_def_val
  end

  def test_module_cattr_reader
    TestClass.class_eval { cattr_reader :class_variable }

    assert_equal TestClass.class_variable, 'class variable'
  end

  def test_module_cattr_writer
    TestClass.class_eval { cattr_writer :class_variable }
    TestClass.class_variable = 'test'

    assert_equal TestClass.class_variable, 'test'
  end
end
