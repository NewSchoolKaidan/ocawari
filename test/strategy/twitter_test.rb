require "test_helper"
require "ocawari/strategy/twitter"

class TwitterStrategyTest < Minitest::Test
  def test_returns_an_array 
    VCR.use_cassette "twitter/festive-kotton4" do 
      uri = Addressable::URI.parse("https://twitter.com/Kotone_LTS/status/728252241270857728")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_four_urls_from_post_with_four_photos
    VCR.use_cassette "twitter/festive-kotton4" do 
      uri = Addressable::URI.parse("https://twitter.com/Kotone_LTS/status/728252241270857728")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute
      
      assert_equal 4, images.count    
    end
  end

  def test_returns_three_urls_from_post_with_three_photos
    VCR.use_cassette "twitter/kj-erinyan3" do 
      uri = Addressable::URI.parse("https://twitter.com/kamiya_erina/status/728432629544984577")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 3, images.count    
    end
  end

  def test_returns_two_urls_from_post_with_two_photos
    VCR.use_cassette "twitter/kj-yua2" do
      uri = Addressable::URI.parse("https://twitter.com/yua_yamashita/status/728472195828060160")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 2, images.count    
    end
  end

  def test_returns_one_url_from_post_with_one_photo
    VCR.use_cassette "twitter/cp-momoka1" do 
      uri = Addressable::URI.parse("https://twitter.com/CP_momoka_ist/status/728447804331331584")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 1, images.count    
    end
  end

  def test_no_duplicate_urls_in_results
    VCR.use_cassette "twitter/nmb-fuuchan-brody2016" do
      uri = Addressable::URI.parse("https://twitter.com/brody20150821/status/724179467673837568")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal images.uniq.count, images.count
    end
  end

  def test_gets_only_posters_images_and_excludes_comment_images
    VCR.use_cassette "twitter/predia-matsumoto-runa-2" do
      uri = Addressable::URI.parse("https://twitter.com/runaxrunrun/status/728775268534386688")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 2, images.count
    end
  end

  def test_each_image_is_max_resolution
    VCR.use_cassette "twitter/cp-ASAMIN4" do 
      uri = Addressable::URI.parse("https://twitter.com/CP_asami_ist/status/724590169219690498")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert images.all? { |image| image.include?(":large") }
    end
  end
end
