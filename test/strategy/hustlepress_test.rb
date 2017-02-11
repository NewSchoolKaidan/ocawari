require "test_helper"
require "ocawari/strategy/hustlepress"

class HustlepressTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "hustlepress/sugai-yuka-22" do
      uri = Addressable::URI.parse("https://hustlepress.co.jp/keyakizaka46_72/")
      strategy = Ocawari::Strategy::Hustlepress.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "hustlepress/sugai-yuka-22" do
      uri = Addressable::URI.parse("https://hustlepress.co.jp/keyakizaka46_72/")
      strategy = Ocawari::Strategy::Hustlepress.new(uri)
      images = strategy.execute

      assert_equal 22, images.count
    end
  end
end
