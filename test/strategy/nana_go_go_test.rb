require "test_helper"
require "ocawari/strategy/nana_go_go"

class NanaGoGoTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "755/hkt-sakaguchi-riko-1" do
      uri = Addressable::URI.parse("https://7gogo.jp/sakaguchi-riko/11075")
      strategy = Ocawari::Strategy::NanaGoGo.new(uri)
      images = strategy.execute

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "755/akb-okada-nana-1" do
      uri = Addressable::URI.parse("https://7gogo.jp/okada-nana/10427")
      strategy = Ocawari::Strategy::NanaGoGo.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
    end
  end
end
