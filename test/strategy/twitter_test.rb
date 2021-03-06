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
      images = Ocawari.parse("https://twitter.com/Kotone_LTS/status/728252241270857728")
      
      assert_equal 4, images.count    
    end
  end

  def test_returns_three_urls_from_post_with_three_photos
    VCR.use_cassette "twitter/tsuribit-sakuchin" do 
      uri = Addressable::URI.parse("https://twitter.com/tsuribit_sakura/status/848898159606505472")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 3, images.count    
    end
  end

  def test_returns_two_urls_from_post_with_two_photos
    VCR.use_cassette "twitter/akb48-SAHO2" do
      uri = Addressable::URI.parse("https://twitter.com/yahho_sahho/status/846748153915236352")
      strategy = Ocawari::Strategy::Twitter.new(uri)
      images = strategy.execute

      assert_equal 2, images.count    
    end
  end

  def test_returns_one_url_from_post_with_one_photo
    VCR.use_cassette "twitter/akb-onishi-momoka" do 
      uri = Addressable::URI.parse("https://twitter.com/momo_0x0_920/status/998522253229740033")
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

  def test_gets_images_when_specifying_user_agent
    # For some reason, not specifying the user agent
    # now returns the mobile page for twitter so now
    # we must use user agents

    VCR.use_cassette "twitter/akb-nozawa-rena" do 
      images = Ocawari.parse("https://twitter.com/RENAN0ZAWA/status/998712108618465281")

      assert 2, images.count
    end
  end
end