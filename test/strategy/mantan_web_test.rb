require "test_helper"
require "ocawari/strategy/mantan_web"

class MantanWebTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "mantan_web/asakawa-nana-photobook-lifesize-10" do
      uri = Addressable::URI.parse("http://mantan-web.jp/2017/01/29/20170129dog00m200019000c.html")
      strategy = Ocawari::Strategy::MantanWeb.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "mantan_web/asakawa-nana-photobook-lifesize-10" do
      uri = Addressable::URI.parse("http://mantan-web.jp/2017/01/29/20170129dog00m200019000c.html")
      strategy = Ocawari::Strategy::MantanWeb.new(uri)
      images = strategy.execute

      assert_equal 10, images.count
    end
  end

  def test_all_images_are_max_resolution
    VCR.use_cassette "mantan_web/asakawa-nana-photobook-lifesize-10" do
      uri = Addressable::URI.parse("http://mantan-web.jp/2017/01/29/20170129dog00m200019000c.html")
      strategy = Ocawari::Strategy::MantanWeb.new(uri)
      images = strategy.execute

      assert images.all? { |image| image.include?("size10") }
    end
  end
end
