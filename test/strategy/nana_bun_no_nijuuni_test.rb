require "test_helper"
require "ocawari/strategy/nana_bun_no_nijuuni"

class NanaBunNoNijuuniTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "22-7/sally" do
      uri = Addressable::URI.parse("http://blog.nanabunnonijyuuni.com/s/n227/diary/detail/1112?ima=2559&cd=blog")
      strategy = Ocawari::Strategy::NanaBunNoNijuuni.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "22-7/sally" do
      uri = Addressable::URI.parse("http://blog.nanabunnonijyuuni.com/s/n227/diary/detail/1112?ima=2559&cd=blog")
      strategy = Ocawari::Strategy::NanaBunNoNijuuni.new(uri)
      images = strategy.execute

      assert_equal 3, images.count
    end
  end
end