require "test_helper"
require "ocawari/strategy/line"

class LineStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "line/kimura-misa-5" do
      uri = Addressable::URI.parse("http://lineblog.me/kimuramisa/archives/5950658.html")
      strategy = Ocawari::Strategy::Line.new(uri)
      images = strategy.execute

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "line/kimura-misa-5" do
      uri = Addressable::URI.parse("http://lineblog.me/kimuramisa/archives/5950658.html")
      strategy = Ocawari::Strategy::Line.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end

  def test_returns_images_at_max_resolution
    VCR.use_cassette "line/kimura-misa-5" do
      uri = Addressable::URI.parse("http://lineblog.me/kimuramisa/archives/5950658.html")
      strategy = Ocawari::Strategy::Line.new(uri)
      images = strategy.execute

      all_images_at_max_resolution = images.all? do |url|
        !url.include?("-s.") &&
        !!(url =~ /\.(jpg|JPEG|jpeg|png|gif)$/)
      end

      assert all_images_at_max_resolution
    end
  end

  def test_returns_unique_images
    # The way that images are served by LINE is different from
    # previous tests. Images in this test are backed by a CDN and
    # are all the suffixed at the end of the url with "small". 
    # This leads to multiple images being downloaded with the
    # filename "small" and being downloaded at lower resolutions.

    VCR.use_cassette "line/yamada-nami" do
      uri = Addressable::URI.parse("http://lineblog.me/musubizm/archives/1062407944.html")
      strategy = Ocawari::Strategy::Line.new(uri)
      images = strategy.execute

      any_images_suffixed_with_small = images.any? { |url| url =~ /\/small$/ }

      refute any_images_suffixed_with_small
    end
  end
end
