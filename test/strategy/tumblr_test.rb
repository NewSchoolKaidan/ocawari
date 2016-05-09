require "test_helper"
require "ocawari/strategy/tumblr"

class TumblrStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      url = "http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1"
      results = Ocawari::Strategy::Tumblr.(url)
      assert_equal Array, results.class
    end
  end

  def test_parses_for_images_within_embedded_iframe
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      url = "http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 5, images.count
    end
  end

  def test_parses_for_images_in_normal_document
    VCR.use_cassette "tumblr/shiroma-miru-young-jump-march-2016" do
      url = "http://tsuna1223.tumblr.com/post/140853208882/%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0%E3%81%AE%E3%83%A4%E3%83%B3%E3%82%B0%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%97%E3%81%AE2016%E5%B9%B4%E3%81%AE%E6%9C%80%E6%96%B0%E7%94%BB%E5%83%8F%E3%81%8C%E8%89%B2%E6%B0%97%E3%81%9F%E3%81%A3%E3%81%B7%E3%82%8A%E9%AB%98%E7%94%BB%E8%B3%AA%E7%89%88"

      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 8, images.count
    end
  end

  def test_one_more_tumblr_url
    VCR.use_cassette "tumblr/shiroma-miru-extaishu-july-2015" do
      url = "http://www.voz48.xyz/post/134632615986/ex-taishu-jul-2015"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 8, images.count
    end
  end

  def test_tumblr_url_with_no_trailing_backslash_after_numerical_id
    VCR.use_cassette "tumblr/kato-rena-10" do 
      url = "http://tokyo-akb48.tumblr.com/post/140480736666"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 10, images.count
    end
  end

  def test_gets_target_displayed_at_height_250
    VCR.use_cassette "tumblr/nmb-fuuchan-6" do 
      url = "http://cubo48.tumblr.com/post/133937468485/blt-graph-vol4-yagura-fuuko-x"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 6, images.count
    end
  end

  def test_gets_target_displayed_at_height_400
    VCR.use_cassette "tumblr/akb-yuria-6" do 
      url = "http://moe48jp.tumblr.com/post/92436537774"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 6, images.count
    end
  end

  def test_gets_target_displayed_at_height_540
    VCR.use_cassette "tumblr/akb-yuria-6" do 
      url = "http://moe48jp.tumblr.com/post/92436537774"
      images = Ocawari::Strategy::Tumblr.(url)

      assert_equal 6, images.count
    end
  end

  
  def test_gets_images_in_max_resolution
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      url = "http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1"
      images = Ocawari::Strategy::Tumblr.(url)

      assert images.all? { |url| url.include?("1280.jpg") }
    end
  end
end
