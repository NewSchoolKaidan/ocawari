require "test_helper"
require "ocawari/strategy/tokyo_idol_net"

class TokyoIdolNetTest < Minitest::Test
  def test_returns_array
    VCR.use_cassette "tokyoidolnet/nijicon-nemoto-nagi-28" do
      url = "http://www.tokyoidol.net/?p=12539" 
      results = Ocawari::Strategy::TokyoIdolNet.(url)

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_photos
    VCR.use_cassette "tokyoidolnet/nijicon-nemoto-nagi-28" do
      url = "http://www.tokyoidol.net/?p=12539" 
      images = Ocawari::Strategy::TokyoIdolNet.(url)

      assert_equal 28, images.count
    end
  end
end
