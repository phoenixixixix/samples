# minimizer_test.rb
require "minitest/autorun"
require './minimizer'

class TestMinimizer < Minitest::Test
  def setup
    @expected_string = "a-dsfsd,fa-c.896e-a3-9x-z7-9 a7-9gg7-19-1-3"
  end

  def test_that_minimize_return_short_string
    assert_equal @expected_string, Minimizer.call('abcdsfsd,fabc.896edcba3456789xyz789 a789gg765432198765432123')
  end
end
