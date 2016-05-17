require "test_helper"
require "ocawari/strategy/ameblo"

class AmebloStrategyTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "ameblo/pidlnagoya-nacchan-5" do
      uri = URI("http://ameblo.jp/pidl-nagoya/entry-12157434206.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_number_of_image_urls
    VCR.use_cassette "ameblo/pidlnagoya-nacchan-5" do
      uri = URI("http://ameblo.jp/pidl-nagoya/entry-12157434206.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      images = strategy.execute

      assert_equal 5, images.count
    end
  end

  def test_returns_expected_number_of_image_urls_from_ohori_megumis_blog
    VCR.use_cassette "ameblo/ohori-megumi" do
      uri = URI("http://ameblo.jp/ohorimegumi/entry-12154414371.html")
      strategy = Ocawari::Strategy::Ameblo.new(uri)
      images = strategy.execute

      assert_equal 7, images.count
    end
  end
end
