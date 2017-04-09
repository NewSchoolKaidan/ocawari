require "test_helper"
require "ocawari/strategy/tv_tokyo"

# Web Archive for sample TVTokyo url
# https://web.archive.org/web/20170409043952/http://www.tv-tokyo.co.jp/yomu/special/951/

class TvTokyoTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "tvtokyo/nijikon-nemotonagi11" do
      uri = Addressable::URI.parse("http://www.tv-tokyo.co.jp/yomu/special/951/")
      strategy = Ocawari::Strategy::TvTokyo.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "tvtokyo/nijikon-nemotonagi11" do
      uri = Addressable::URI.parse("http://www.tv-tokyo.co.jp/yomu/special/951/")
      strategy = Ocawari::Strategy::TvTokyo.new(uri)
      images = strategy.execute

      assert_equal 11, images.count
    end
  end
end
