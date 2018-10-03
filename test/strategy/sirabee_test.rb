require "test_helper"
require "ocawari/strategy/sirabee"

class SirabeeTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "sirabee/ayakawa-hinano-8" do
      url = "http://sirabee.com/2017/03/05/20161076169/"
      images = Ocawari.parse(url)

      assert_equal Array, images.class
    end
  end

  def test_http_scheme_is_valid
    VCR.use_cassette "sirabee/ayakawa-hinano-8" do
      url = "http://sirabee.com/2017/03/05/20161076169/"
      images = Ocawari.parse(url)

      http_scheme_is_not_duplicated = images.all? do |image|
        image.scan("http").count == 1
      end

      assert http_scheme_is_not_duplicated
    end
  end

  def test_returns_expected_amount_of_image_urls
    VCR.use_cassette "sirabee/ayakawa-hinano-8" do
      url = "http://sirabee.com/2017/03/05/20161076169/"
      images = Ocawari.parse(url)

      assert_equal 8, images.count
    end
  end

  def test_page_with_gallery
    VCR.use_cassette "sirabee/ayakawa-hinano-8-20180930" do
      url = "https://sirabee.com/2018/09/30/20161815968/"
      images = Ocawari.parse(url)

      assert_equal 8, images.count
    end
  end
end
