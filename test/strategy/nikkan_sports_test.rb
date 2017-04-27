require "test_helper"
require "ocawari/strategy/nikkan_sports"

class NikkanSportsTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "nikkan_sports/kayoyon" do
      uri = Addressable::URI.parse("http://www.nikkansports.com/entertainment/akb48/news/1814126.html")
      strategy = Ocawari::Strategy::NikkanSports.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "nikkan_sports/kayoyon" do
      uri = Addressable::URI.parse("http://www.nikkansports.com/entertainment/akb48/news/1814126.html")
      strategy = Ocawari::Strategy::NikkanSports.new(uri)
      images = strategy.execute

      assert_equal 3, images.count
    end
  end
end
