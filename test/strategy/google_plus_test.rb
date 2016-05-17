require "test_helper"
require "ocawari/strategy/google_plus"

class GooglePlusTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "googleplus/hkt-sakura-1" do
      uri = URI("https://plus.google.com/102808008463301583196/posts/fcZbKdBhWPy")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_number_of_image_urls
    VCR.use_cassette "googleplus/nmb-fuuchan-35" do
      uri = URI("https://plus.google.com/110515811233847190239/posts/c6cWgY3fQnB")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      images = strategy.execute

      assert_equal 35, images.count
    end
  end

  def test_returns_one_image_when_only_one_image_present
    VCR.use_cassette "googleplus/akb-happyness-1" do
      uri = URI("https://plus.google.com/105835152133357364264/posts/ERcEbSPit8U")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
    end
  end

  def test_one_more_url_for_good_measure
    VCR.use_cassette "googleplus/akb-SSSAAHHOO-1" do
      uri = URI("https://plus.google.com/116138450385389714584/posts/Wo9WM8wqYYi")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
    end
  end

  def test_images_are_returned_in_max_resolution
    VCR.use_cassette "googleplus/nmb-fuuchan-35" do
      uri = URI("https://plus.google.com/110515811233847190239/posts/c6cWgY3fQnB")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      images = strategy.execute

      all_images_are_max_resolution = 
        images.all? { |url| url.include?("/s0/")}

      assert all_images_are_max_resolution
    end
  end
end
