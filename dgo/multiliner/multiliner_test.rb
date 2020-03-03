# multiliner_test.rb
require "minitest/autorun"
require './multiliner'

class TestMultiliner < Minitest::Test
  def setup
    @expected_result_5 = ["To be", "or", "not", "to be", "that", "is", "the", "quest", "ion"]
    @expected_result_7 = ["To be", "or not", "to be", "that is", "the", "questio", "n"]
  end

  def test_that_multiline_return_short_string
    assert_equal @expected_result_5, Multiliner.call('To be or not to be that is the question', 5)
    assert_equal @expected_result_7, Multiliner.call('To be or not to be that is the question', 7)
  end
end
