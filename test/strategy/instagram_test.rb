require "test_helper"
require "ocawari/strategy/instagram"

class InstagramTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "instagram/akb-hilary-1" do
      uri = URI("https://www.instagram.com/p/BFBaEBAzTEv")
      results = Ocawari::Strategy::Instagram.(uri)

      assert_equal Array, results.class
    end
  end

  def test_returns_image
    VCR.use_cassette "instagram/akb-hilary-1" do
      uri = URI("https://www.instagram.com/p/BFBaEBAzTEv")
      images = Ocawari::Strategy::Instagram.(uri)

      assert_equal 1, images.count
    end
  end

  def test_returns_image_when_given_url_showing_taken_by
    VCR.use_cassette "instagram.akb-hilary-1-2" do
      uri = URI("https://www.instagram.com/p/BFD1l9kzTMT/?taken-by=hirari_official")
      images = Ocawari::Strategy::Instagram.(uri)
      image = images[0]

      assert_equal 1, images.count
      assert_match /13102488_879814098811218_722514269/, image
    end
  end
end
