require "test_helper"
require "ocawari/strategy/line"

class LogirlStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "logirl/tsuribit-ayutan" do
      uri = Addressable::URI.parse("https://logirl.favclip.com/article/detail/5146591566495744")
      strategy = Ocawari::Strategy::Logirl.new(uri)
      images = strategy.execute

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "logirl/tsuribit-ayutan" do
      uri = Addressable::URI.parse("https://logirl.favclip.com/article/detail/5146591566495744")
      strategy = Ocawari::Strategy::Logirl.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end

  def test_returns_expected_amount_of_image_on_older_article
    VCR.use_cassette "logirl/tsuribit-nacchan-20150420-article" do
      uri = Addressable::URI.parse("https://logirl.favclip.com/article/detail/5726461709254656")
      strategy = Ocawari::Strategy::Logirl.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end
end
