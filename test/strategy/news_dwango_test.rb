require "test_helper"
require "ocawari/strategy/natalie"

class NewsDwangoTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "news_dwango/oonuki-sayaka-8" do
      uri = Addressable::URI.parse("https://news.dwango.jp/2017/01/27/120502/gravure/")
      strategy = Ocawari::Strategy::NewsDwango.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "news_dwango/oonuki-sayaka-8" do
      uri = Addressable::URI.parse("https://news.dwango.jp/2017/01/27/120502/gravure/")
      strategy = Ocawari::Strategy::NewsDwango.new(uri)
      images = strategy.execute

      assert_equal 8, images.count
    end
  end
end
