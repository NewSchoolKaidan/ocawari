require "test_helper"
require "ocawari/strategy/imgur"

class ImgurTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "imgur/akb-tomu-brody20160222-9" do
      uri = Addressable::URI.parse("http://imgur.com/a/Xx5JN")
      strategy = Ocawari::Strategy::Imgur.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "imgur/akb-tomu-brody20160222-9" do
      uri = Addressable::URI.parse("http://imgur.com/a/Xx5JN")
      strategy = Ocawari::Strategy::Imgur.new(uri)
      images = strategy.execute

      assert_equal 10, images.count
    end
  end

  def test_image_urls_have_http_scheme
    VCR.use_cassette "imgur/akb-tomu-brody20160222-9" do
      uri = Addressable::URI.parse("http://imgur.com/a/Xx5JN")
      strategy = Ocawari::Strategy::Imgur.new(uri)
      images = strategy.execute

      assert images.all? { |url| /http:/.match?(url) }
    end
  end
end
