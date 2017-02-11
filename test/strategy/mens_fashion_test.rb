require "test_helper"
require "ocawari/strategy/mens_fashion"

class MensFashionTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "mens_fashion/morikanon-143" do
      uri = Addressable::URI.parse("http://mensfashion.cc/interviews/morikanon/")
      strategy = Ocawari::Strategy::MensFashion.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "mens_fashion/morikanon-143" do
      uri = Addressable::URI.parse("http://mensfashion.cc/interviews/morikanon/")
      strategy = Ocawari::Strategy::MensFashion.new(uri)
      images = strategy.execute

      assert_equal 144, images.count
    end
  end
end
