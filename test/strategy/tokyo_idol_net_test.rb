require "test_helper"
require "ocawari/strategy/tokyo_idol_net"

class TokyoIdolNetTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "tokyoidolnet/nijicon-nemoto-nagi-28" do
      uri = Addressable::URI.parse("http://www.tokyoidol.net/?p=12539") 
      strategy = Ocawari::Strategy::TokyoIdolNet.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_photos
    VCR.use_cassette "tokyoidolnet/nijicon-nemoto-nagi-28" do
      uri = Addressable::URI.parse("http://www.tokyoidol.net/?p=12539") 
      strategy = Ocawari::Strategy::TokyoIdolNet.new(uri)
      images = strategy.execute

      assert_equal 28, images.count
    end
  end
end
