require "test_helper"
require "ocawari/strategy/kaiyou"

class KaiyouTest < Minitest::Test
  def setup
    @uri = URI("http://kai-you.net/article/28983")
  end

  def test_returns_array
    VCR.use_cassette "kaiyou/tsuribit-nacchan-20" do
      strategy = Ocawari::Strategy::Kaiyou.new(@uri)
      images = strategy.execute

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "kaiyou/tsuribit-nacchan-20" do
      strategy = Ocawari::Strategy::Kaiyou.new(@uri)
      images = strategy.execute

      assert_equal 20, images.count
    end
  end

  def test_returns_images_at_max_resolution
    VCR.use_cassette "kaiyou/tsuribit-nacchan-20" do
      strategy = Ocawari::Strategy::Kaiyou.new(@uri)
      images = strategy.execute

      assert images.all? { |url| url =~ /press\/img/ }
    end
  end
end
