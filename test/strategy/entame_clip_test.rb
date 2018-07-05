require "test_helper"
require "ocawari/strategy/entame_clip"

class EntameClipTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "entameclip/hinano" do
      uri = Addressable::URI.parse("https://entameclip.com/topics/118868")
      strategy = Ocawari::Strategy::EntameClip.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "entameclip/hinano" do
      images = Ocawari.parse("https://entameclip.com/topics/118868")

      assert_equal 8, images.count
    end
  end
end