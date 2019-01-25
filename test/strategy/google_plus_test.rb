require "test_helper"
require "ocawari/strategy/google_plus"

class GooglePlusTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "googleplus/hkt-sakura-1" do
      results = Ocawari.parse("https://plus.google.com/102808008463301583196/posts/fcZbKdBhWPy") 

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_number_of_image_urls
    VCR.use_cassette "googleplus/nmb-fuuchan-35" do
      images = Ocawari.parse("https://plus.google.com/110515811233847190239/posts/c6cWgY3fQnB")

      assert_equal 35, images.count
    end
  end

  def test_returns_one_image_when_only_one_image_present
    VCR.use_cassette "googleplus/akb-happyness-1" do
      uri = Addressable::URI.parse("https://plus.google.com/105835152133357364264/posts/ERcEbSPit8U")
      strategy = Ocawari::Strategy::GooglePlus.new(uri)
      images = strategy.execute

      assert_equal 1, images.count
    end
  end

  def test_one_more_url_for_good_measure
    VCR.use_cassette "googleplus/akb-SSSAAHHOO-1" do
      images = Ocawari.parse("https://plus.google.com/116138450385389714584/posts/Wo9WM8wqYYi")

      assert_equal 1, images.count
    end
  end

  def test_images_are_returned_in_max_resolution
    VCR.use_cassette "googleplus/hkt-miku-20190125" do
      images = Ocawari.parse("https://plus.google.com/u/2/108158383330906277526/posts/eZS7xsggYwU")

      image_dimensions = images.map { |image| MiniMagick::Image.open(image).dimensions }

      all_images_are_max_resolution = 
        image_dimensions.count { |dimensions| dimensions == [2880, 2160] } == 2 &&
        image_dimensions.count { |dimensions| dimensions == [2160, 2880] } == 2

      assert all_images_are_max_resolution
    end
  end

  def test_returns_images_when_url_includes_user_account_identifier
    VCR.use_cassette "googleplus/hkt-NACCHAN" do
      # Needs to remove the /u/1/ part
      images = Ocawari.parse("https://plus.google.com/u/1/107241677527739013868/posts/QNT8Kg5nj14")

      assert_equal 1, images.count
    end
  end

  def test_returns_images_when_url_includes_user_account_identifier_part2
    VCR.use_cassette "googleplus/hkt-MIKUUUUUU" do
      # integrated test
      images = Ocawari.parse("https://plus.google.com/u/1/108158383330906277526/posts/6bFmhxMgrxr")

      assert_equal 1, images.count
    end
  end
end