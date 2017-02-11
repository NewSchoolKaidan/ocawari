require "test_helper"
require "ocawari/strategy/stereo_sound"

class StereoSoundTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "stereo_sound/why-doll-chiharun-birthday-21" do
      uri = Addressable::URI.parse("http://www.stereosound.co.jp/column/idollove/article/2017/01/23/53214.html")
      strategy = Ocawari::Strategy::StereoSound.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "stereo_sound/why-doll-chiharun-birthday-21" do
      uri = Addressable::URI.parse("http://www.stereosound.co.jp/column/idollove/article/2017/01/23/53214.html")
      strategy = Ocawari::Strategy::StereoSound.new(uri)
      images = strategy.execute

      assert_equal 21, images.count
    end
  end
end
