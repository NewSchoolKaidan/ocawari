require "test_helper"
require "ocawari/strategy/natalie"

class NatalieTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "natalie/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("http://natalie.mu/music/news/213794")
      strategy = Ocawari::Strategy::Natalie.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "natalie/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("http://natalie.mu/music/news/213794")
      strategy = Ocawari::Strategy::Natalie.new(uri)
      images = strategy.execute

      assert_equal 4, images.count
    end
  end

  def test_ensures_max_resolution
    VCR.use_cassette "natalie/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("http://natalie.mu/music/news/213794")
      strategy = Ocawari::Strategy::Natalie.new(uri)
      images = strategy.execute

      assert images.all? do |image|
        image.include?("http://cdn2.natalie.mu") &&
        image.include?("news_xlarge")
      end
    end
  end
end
