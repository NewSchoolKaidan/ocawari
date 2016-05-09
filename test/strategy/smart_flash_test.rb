require "test_helper"
require "ocawari/strategy/smart_flash"

class SmartFlashTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "smartflash/kj-kamiya-erina-5" do
      url = "http://smart-flash.jp/gravure/5390"
      results = Ocawari::Strategy::SmartFlash.(url)

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "smartflash/kj-kamiya-erina-5" do
      url = "http://smart-flash.jp/gravure/5390"
      images = Ocawari::Strategy::SmartFlash.(url)

      assert_equal 5, images.count
    end
  end
end
