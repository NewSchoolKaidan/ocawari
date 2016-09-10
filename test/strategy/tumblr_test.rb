require "test_helper"
require "ocawari/strategy/tumblr"

class TumblrStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      uri = URI("http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_parses_for_images_within_embedded_iframe
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      uri = URI("http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end

  def test_parses_for_images_in_normal_document
    VCR.use_cassette "tumblr/shiroma-miru-young-jump-march-2016" do
      uri = URI("http://tsuna1223.tumblr.com/post/140853208882/%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0%E3%81%AE%E3%83%A4%E3%83%B3%E3%82%B0%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%97%E3%81%AE2016%E5%B9%B4%E3%81%AE%E6%9C%80%E6%96%B0%E7%94%BB%E5%83%8F%E3%81%8C%E8%89%B2%E6%B0%97%E3%81%9F%E3%81%A3%E3%81%B7%E3%82%8A%E9%AB%98%E7%94%BB%E8%B3%AA%E7%89%88")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 8, images.count
    end
  end

  def test_one_more_tumblr_url
    VCR.use_cassette "tumblr/shiroma-miru-extaishu-july-2015" do
      uri = URI("http://www.voz48.xyz/post/134632615986/ex-taishu-jul-2015")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 8, images.count
    end
  end

  def test_tumblr_url_with_no_trailing_backslash_after_numerical_id
    VCR.use_cassette "tumblr/kato-rena-10" do 
      uri = URI("http://tokyo-akb48.tumblr.com/post/140480736666")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 10, images.count
    end
  end

  def test_gets_target_displayed_at_height_250
    VCR.use_cassette "tumblr/nmb-fuuchan-6" do 
      uri = URI("http://cubo48.tumblr.com/post/133937468485/blt-graph-vol4-yagura-fuuko-x")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 6, images.count
    end
  end

  def test_gets_target_displayed_at_height_400
    VCR.use_cassette "tumblr/akb-yuria-6" do 
      uri = URI("http://moe48jp.tumblr.com/post/92436537774")
      strategy =  Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 6, images.count
    end
  end

  def test_gets_target_displayed_at_height_540
    VCR.use_cassette "tumblr/akb-yuria-6" do 
      uri = URI("http://moe48jp.tumblr.com/post/92436537774")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 6, images.count
    end
  end

  
  def test_gets_images_in_max_resolution
    VCR.use_cassette "tumblr/shiroma-miru-flash-special-2016" do 
      uri = URI("http://miruwomiru.tumblr.com/post/143735710050/flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2-best2016-gw%E5%8F%B7-%E7%99%BD%E9%96%93%E7%BE%8E%E7%91%A0-%E5%A7%8B%E5%8B%95-part-1")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert images.all? { |url| url.include?("1280.jpg") }
    end
  end

  def test_no_empty_spaces
    VCR.use_cassette "tumblr/hkt-sakura-young-champion-no11-2016" do
      uri = URI("http://www.i.voz48.xyz/post/144125258480/young-champion-no11-2016")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      refute images.any? { |url| url.match(/[\s\n\t]/) }, "Images should not contain any empty spaces, newlines, etc."
    end
  end

  def test_no_image_nodes_on_page
    VCR.use_cassette "tumblr/saho-flash-special-gravure-2015" do
      uri = URI("http://luckynumber48-magz.tumblr.com/post/123449923017/iwatate-saho-flash%E3%82%B9%E3%83%9A%E3%82%B7%E3%83%A3%E3%83%AB-%E3%82%B0%E3%83%A9%E3%83%93%E3%82%A2best-2015")
      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 8, images.count
    end
  end

  def test_looks_for_images_with_different_meta_comments
    VCR.use_cassette "tumblr/asakawa-nana-2016-young-magazine-issue-36-ebook" do
      uri = URI("https://sug-bug.tumblr.com/post/148542905592/amazoncojp-%E3%83%A4%E3%83%B3%E3%82%B0%E3%83%9E%E3%82%AC%E3%82%B8%E3%83%B3-2016%E5%B9%B426%E5%8F%B7-2016%E5%B9%B45%E6%9C%8830%E6%97%A5%E7%99%BA%E5%A3%B2-%E9%9B%91%E8%AA%8C")

      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
    end
  end

  def test_get_highest_resolution_png
    VCR.use_cassette "tumblr/asakawa-nana-2016-young-magazine-issue-36-ebook" do
      uri = URI("https://sug-bug.tumblr.com/post/148542905592/amazoncojp-%E3%83%A4%E3%83%B3%E3%82%B0%E3%83%9E%E3%82%AC%E3%82%B8%E3%83%B3-2016%E5%B9%B426%E5%8F%B7-2016%E5%B9%B45%E6%9C%8830%E6%97%A5%E7%99%BA%E5%A3%B2-%E9%9B%91%E8%AA%8C")

      strategy = Ocawari::Strategy::Tumblr.new(uri)
      images = strategy.execute
      image = images.first

      assert image.include?("1280.png")
    end
  end
end
