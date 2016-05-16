require "test_helper"
require "ocawari/strategy/line"

class LineStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "line/kimura-misa-5" do
      uri = URI("http://lineblog.me/kimuramisa/archives/5950658.html")
      images = Ocawari::Strategy::Line.(uri)

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "line/kimura-misa-5" do
      uri = URI("http://lineblog.me/kimuramisa/archives/5950658.html")
      images = Ocawari::Strategy::Line.(uri)

      assert_equal 5, images.count
    end
  end

  def test_returns_images_at_max_resolution
    VCR.use_cassette "line/kimura-misa-5" do
      uri = URI("http://lineblog.me/kimuramisa/archives/5950658.html")
      images = Ocawari::Strategy::Line.(uri)

      all_images_at_max_resolution = 
        images.all? { |url| !url.include?("-s.jpg") }

      assert all_images_at_max_resolution
    end
  end
end
