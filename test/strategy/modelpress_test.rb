require "test_helper"
require "ocawari/strategy/modelpress"

class ModelPressTest < Minitest::Test
  def test_returns_an_array
    VCR.use_cassette "modelpress/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("https://mdpr.jp/news/detail/1647057")
      strategy = Ocawari::Strategy::ModelPress.new(uri)
      results = strategy.execute

      assert_equal Array, results.class
    end
  end

  def test_returns_expected_amount_of_images
    VCR.use_cassette "modelpress/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("https://mdpr.jp/news/detail/1647057")
      strategy = Ocawari::Strategy::ModelPress.new(uri)
      images = strategy.execute

      assert_equal 4, images.count
    end
  end

  def test_ensures_max_resolution
    VCR.use_cassette "modelpress/asakawa-nana-photobook" do
      uri = Addressable::URI.parse("https://mdpr.jp/news/detail/1647057")
      strategy = Ocawari::Strategy::ModelPress.new(uri)
      images = strategy.execute

      assert images.all? do |image|
        resolution = image[/w(\d{3,})/, 1]
        resolution.to_a >= 600
      end
    end
  end

  def test_returns_expected_amount_of_images_from_different_path
    VCR.use_cassette "modelpress/katorena-iriyamaanna-kansai-collection" do
      uri = Addressable::URI.parse("https://mdpr.jp/interview/detail/1677179")

      strategy = Ocawari::Strategy::ModelPress.new(uri)
      images = strategy.execute

      all_images_contain_only_one_http_scheme = images.all? do |image|
        image.scan(/https?/).count == 1
      end

      assert images.count == 11 
      assert all_images_contain_only_one_http_scheme, "One or more images contained an image url with multiple http schemes (e.g. https://wwwhttps://www vs https://)"
    end
  end
end
