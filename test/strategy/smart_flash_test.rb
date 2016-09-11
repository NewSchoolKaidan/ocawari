require "test_helper"
require "ocawari/strategy/smart_flash"

class SmartFlashTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "smartflash/kj-kamiya-erina-5" do
      uri = Addressable::URI.parse("http://smart-flash.jp/gravure/5390")
      strategy = Ocawari::Strategy::SmartFlash.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "smartflash/kj-kamiya-erina-5" do
      uri = Addressable::URI.parse("http://smart-flash.jp/gravure/5390")
      strategy = Ocawari::Strategy::SmartFlash.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end
end
