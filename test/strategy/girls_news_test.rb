require "test_helper"
require "ocawari/strategy/girls_news"

class GirlsNewsTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "girls_news/fujie-reina-graduation-3" do
      uri = Addressable::URI.parse("http://girlsnews.tv/akb/286302")
      strategy = Ocawari::Strategy::GirlsNews.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "girls_news/fujie-reina-graduation-3" do
      uri = Addressable::URI.parse("http://girlsnews.tv/akb/286302")
      strategy = Ocawari::Strategy::GirlsNews.new(uri)
      images = strategy.execute

      assert_equal 3, images.count
    end
  end

  def test_all_images_are_max_resolution
    VCR.use_cassette "girls_news/fujie-reina-graduation-3" do
      uri = Addressable::URI.parse("http://girlsnews.tv/akb/286302")
      strategy = Ocawari::Strategy::GirlsNews.new(uri)
      images = strategy.execute

      assert images.all? { |image| image.include?("w1000") }
    end
  end
end
