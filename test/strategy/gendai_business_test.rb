require "test_helper"
require "ocawari/strategy/gendai_business"

class GendaiBusinessTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "gendai_business/takahashi-juri-20190125" do
      results = Ocawari.parse("https://gendai.ismedia.jp/articles/-/59438")

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "gendai_business/takahashi-juri-20190125" do
      images = Ocawari.parse("https://gendai.ismedia.jp/articles/-/59438")

      assert_equal 7, images.count
    end
  end
end