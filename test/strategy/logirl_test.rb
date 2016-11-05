require "test_helper"
require "ocawari/strategy/line"

class LogirlStrategyTest < Minitest::Test
  def setup
    @uri = Addressable::URI.parse("https://logirl.favclip.com/article/detail/5146591566495744")
  end

  def test_returns_array
    VCR.use_cassette "logirl/tsuribit-ayutan" do
      strategy = Ocawari::Strategy::Logirl.new(@uri)
      images = strategy.execute

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "logirl/tsuribit-ayutan" do
      strategy = Ocawari::Strategy::Logirl.new(@uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end
end
