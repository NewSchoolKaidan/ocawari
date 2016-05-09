require "test_helper"
require "ocawari/strategy/no_match"

class NoMatchTest < Minitest::Test
  def test_returns_an_array
    assert_equal Array, Ocawari::Strategy::NoMatch.("ASAMIN").class
  end

  def test_given_anything_returns_empty_array
    assert Ocawari::Strategy::NoMatch.("ASAMIN").empty?
    assert Ocawari::Strategy::NoMatch.(["ASAMIN", "ASAMIN"]).empty?
  end
end
