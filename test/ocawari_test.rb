require 'test_helper'
require "ocawari/strategy_delegator"

class OcawariTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ocawari::VERSION
  end

  def test_returns_an_array_given_a_string_argument 
    VCR.use_cassette "twitter/festive-kotton4" do 
      image_urls = Ocawari.parse("https://twitter.com/Kotone_LTS/status/728252241270857728")

      assert_equal Array, image_urls.class
    end
  end

  def test_returns_an_array_given_an_array_argument
    VCR.use_cassette "twitter/nmb-aapon1" do
      image_urls = Ocawari.parse(["https://twitter.com/ayaka1o11/status/728179986981519360"])

      assert_equal Array, image_urls.class
    end
  end

  def test_raises_if_given_argument_other_than_array_or_string
    assert_raises { Ocawari.parse(4846) }
  end

  def test_returns_one_dimensional_array
    VCR.use_cassette "set_of_urls" do
      urls = %w(
        https://twitter.com/gen_SQ27/status/728817073342849024
        https://twitter.com/gen_SQ27/status/728815045136678912
        https://twitter.com/Hitomi_hiychan/status/728807006920794112
        https://twitter.com/nyoki_n/status/728814801997037568
        https://twitter.com/honda49892000/status/728800724235079680
        https://twitter.com/nyoki_n/status/728808506250297344
      )

      images = Ocawari.parse(urls)

      arrays_among_resulting_images = images.any? do |image|
        image.class == Array
      end

      refute arrays_among_resulting_images 
    end
  end

  def test_resulting_images_are_all_strings
    VCR.use_cassette "set_of_urls" do
      urls = %w(
        https://twitter.com/gen_SQ27/status/728817073342849024
        https://twitter.com/gen_SQ27/status/728815045136678912
        https://twitter.com/Hitomi_hiychan/status/728807006920794112
        https://twitter.com/nyoki_n/status/728814801997037568
        https://twitter.com/honda49892000/status/728800724235079680
        https://twitter.com/nyoki_n/status/728808506250297344
      )

      images = Ocawari.parse(urls)

      images_are_all_strings = images.all? do |image|
        image.class == String
      end

      assert images_are_all_strings
    end
  end

  def test_prefix_url_if_http_scheme_is_missing_from_url
    VCR.use_cassette "ameblo/kusunoki-mayu-entry-12160755427" do
      url = "ameblo.jp/kusunoki-mayu/entry-12160755427.html"
      images = Ocawari.parse(url)

      assert_equal 6, images.count
    end
  end
  
  def test_normalizes_non_ascii_urls
    VCR.use_cassette "tumblr/asakawa-nana-2016-weekly-young-magazine-no-18"  do
      url = "http://unknown634.tumblr.com/post/142237853450/浅川梨奈-wym2016-no18"

      images = Ocawari.parse(url)

      assert_equal 7, images.count
    end
  end

  def test_normalizes_multiple_non_ascii_urls
    VCR.use_cassette "normalizes_multiple_non_ascii_urls" do
      urls = %w(
        http://yoimachi.tumblr.com/post/134769414906/浅川梨奈
        http://tsuna1223.tumblr.com/post/140068454897/浅川梨奈のtumblrで見つけた水着や制服姿の画像がすごすぎる件-httptsuna-kyo
      )

      images = Ocawari.parse(urls)

      assert_equal 9, images.count
    end
  end
end
