require "test_helper"
require "ocawari/strategy/keyakizaka46"

class Keyakizaka46StrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "keyakizaka46/sugai-yuuka-3" do
      uri = Addressable::URI.parse("http://www.keyakizaka46.com/s/k46o/diary/detail/7352?ima=0000&cd=member")
      strategy = Ocawari::Strategy::Keyakizaka46.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_number_of_image_urls
    VCR.use_cassette "keyakizaka46/sugai-yuuka-3" do
      uri = Addressable::URI.parse("http://www.keyakizaka46.com/s/k46o/diary/detail/7352?ima=0000&cd=member")
      strategy = Ocawari::Strategy::Keyakizaka46.new(uri)
      images = strategy.execute

      assert_equal 3, images.count
    end
  end
end
