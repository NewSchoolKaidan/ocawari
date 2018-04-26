require "test_helper"
require "ocawari/strategy/nana_go_go"

class NanaGoGoTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "755/hkt-sakaguchi-riko-1" do
      images = Ocawari.parse("https://7gogo.jp/sakaguchi-riko/11075")

      assert_equal Array, images.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "755/akb-okada-nana-1" do
      images = Ocawari.parse("https://7gogo.jp/okada-nana/10427")

      assert_equal 1, images.count
    end
  end

  def test_returns_expected_amount_of_images_integrated
    VCR.use_cassette "755/akb-mogimogi" do
      images = Ocawari.parse("https://7gogo.jp/uV__cTAd3dLN/4205")

      assert_includes images, "https://stat.7gogo.jp/appimg_images/20180408/08/d6/rK/j/o19201443p.jpg"
    end
  end
end
