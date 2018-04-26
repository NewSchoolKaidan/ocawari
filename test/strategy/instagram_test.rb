require "test_helper"
require "ocawari/strategy/instagram"

class InstagramTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "instagram/akb-hilary-1" do
      uri = Addressable::URI.parse("https://www.instagram.com/p/BFBaEBAzTEv")
      strategy = Ocawari::Strategy::Instagram.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_image
    VCR.use_cassette "instagram/akb-hilary-1" do
      uri = Addressable::URI.parse("https://www.instagram.com/p/BFBaEBAzTEv")
      strategy = Ocawari::Strategy::Instagram.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
      assert_includes images, "https://scontent-ort2-2.cdninstagram.com/vp/01469cf21a1ce077d213e67fb25224eb/5B619D97/t51.2885-15/e35/13166942_1092176217508448_124621478_n.jpg"
    end
  end

  def test_returns_image_when_given_url_showing_taken_by
    VCR.use_cassette "instagram/akb-hilary-1-2" do
      uri = Addressable::URI.parse("https://www.instagram.com/p/BFD1l9kzTMT/?taken-by=hirari_official")
      strategy = Ocawari::Strategy::Instagram.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
      assert_includes images, "https://scontent-ort2-2.cdninstagram.com/vp/37165cf2918434da5bab30ab8db5fe0c/5B76C1F4/t51.2885-15/e35/13102488_879814098811218_722514269_n.jpg"
    end
  end

  def test_returns_all_images_when_there_is_multiple_images
    VCR.use_cassette "instagram/HIIIIICHAAAAAANNNNNN" do
      uri = Addressable::URI.parse("https://www.instagram.com/p/Bh-TTnWBBwe/")
      strategy = Ocawari::Strategy::Instagram.new(uri)
      images = strategy.execute

      assert_equal 3, images.count
      [
        "https://scontent-ort2-2.cdninstagram.com/vp/1c946e10925ef349c7023ce07b29a0b1/5B7878ED/t51.2885-15/e35/30603486_1670290756398250_7094427774101749760_n.jpg",
        "https://scontent-ort2-2.cdninstagram.com/vp/3e9c110e9f206588641773b497c16c58/5B612F87/t51.2885-15/e35/30605447_360810377761014_5014691471350038528_n.jpg",
        "https://scontent-ort2-2.cdninstagram.com/vp/7105cb5ff21a4a00514a172f5e6e3b71/5B767394/t51.2885-15/e35/30604987_183889195594562_5671295243949965312_n.jpg"
      ].each do |image|
        assert_includes images, image
      end
    end
  end

  def test_returns_image_at_fullest_resolution
    # It won't always be 1080x1080
    VCR.use_cassette "instagram/hikawa-ayame" do
      uri = Addressable::URI.parse("https://www.instagram.com/p/BhB006lguli/?taken-by=ayame_1108")
      strategy = Ocawari::Strategy::Instagram.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
      assert_includes images, "https://scontent-ort2-2.cdninstagram.com/vp/9a504c6430610d504ec4a5e467fcb650/5B761351/t51.2885-15/e35/29418055_2031324107142168_5323587971704684544_n.jpg"
    end
  end
end