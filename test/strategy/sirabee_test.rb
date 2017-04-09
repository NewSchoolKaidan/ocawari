require "test_helper"
require "ocawari/strategy/sirabee"

class SirabeeTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "sirabee/ayakawa-hinano-8" do
      uri = Addressable::URI.parse("http://sirabee.com/2017/03/05/20161076169/")
      strategy = Ocawari::Strategy::Sirabee.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "sirabee/ayakawa-hinano-8" do
      uri = Addressable::URI.parse("http://sirabee.com/2017/03/05/20161076169/")
      strategy = Ocawari::Strategy::Sirabee.new(uri)
      images = strategy.execute

      assert_equal 8, images.count
    end
  end
end
