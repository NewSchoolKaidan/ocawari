require "test_helper"
require "ocawari/strategy/ameblo"

class AmebloStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "ameblo/pidlnagoya-nacchan-5" do
      uri = Addressable::URI.parse("http://ameblo.jp/pidl-nagoya/entry-12157434206.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_number_of_image_urls
    VCR.use_cassette "ameblo/pidlnagoya-nacchan-5" do
      uri = Addressable::URI.parse("http://ameblo.jp/pidl-nagoya/entry-12157434206.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end

  def test_returns_expected_number_of_image_urls_from_ohori_megumis_blog
    VCR.use_cassette "ameblo/ohori-megumi" do
      uri = Addressable::URI.parse("http://ameblo.jp/ohorimegumi/entry-12154414371.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      images = strategy.execute

      assert_equal 7, images.count
    end
  end

  def test_ensures_max_resolution_images
    VCR.use_cassette "ameblo/gojou-senon" do
      uri = Addressable::URI.parse("http://ameblo.jp/satou525/entry-12210977663.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)

      images = strategy.execute

      refute images.any? { |image| /t\d+_/.match?(image) }
      assert images.all? { |image| image.split("/").last[0] == "o" }
    end
  end

  def test_scrubs_leading_metadata
    VCR.use_cassette "ameblo/oonuki-sayaka"  do
      uri = Addressable::URI.parse("http://ameblo.jp/ohnuki-sayaka/entry-12209753925.html")

      strategy = Ocawari::Strategy::Ameblo.new(uri)

      images = strategy.execute

      refute images.any? { |image| /\?caw=800$/.match?(image) }
    end
  end

  def test_returns_images_for_uncommon_html_hierarchy
    VCR.use_cassette "ameblo/matsui-sakiko" do
      uri = Addressable::URI.parse("http://ameblo.jp/sakikomatsui1210/entry-12226963941.html")

      strategy = Ocawari::Strategy::Ameblo.new(uri)

      images = strategy.execute

      assert images.any?, "The Ameblo strategy should return images for this page"
    end
  end
end
