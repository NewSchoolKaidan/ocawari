require "test_helper"
require "ocawari/strategy/nikkan_sports"

class OkMusicJPTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "okmusicjp/onishi-momoka" do
      images = Ocawari.parse("https://okmusic.jp/news/294124?f=tw")

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "okmusicjp/onishi-momoka" do
      images = Ocawari.parse("https://okmusic.jp/news/294124?f=tw")

      assert_equal 35, images.count
    end
  end
end
