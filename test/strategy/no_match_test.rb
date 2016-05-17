require "test_helper"
require "ocawari/strategy/no_match"

class NoMatchTest < Minitest::Test
  def test_returns_an_array
    strategy = Ocawari::Strategy::NoMatch.new("ASAMIN")
    results =  strategy.execute
    assert_equal Array, results.class
  end

  def test_initialized_with_a_string_returns_empty_array
    strategy = Ocawari::Strategy::NoMatch.new("ASAMIN")
    results = strategy.execute
    results_are_empty = results.empty?

    assert results_are_empty
  end

  def test_initialized_with_an_array_returns_empty_array
    strategy = Ocawari::Strategy::NoMatch.new(["ASAMIN", "ASAMIN"])
    results = strategy.execute
    results_are_empty = results.empty?

    assert results_are_empty
  end
end
