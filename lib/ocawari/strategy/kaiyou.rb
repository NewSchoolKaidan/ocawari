module Ocawari
  module Strategy
    class Kaiyou < Parser

      private

      def parse
        ([header_image] + content_images.to_a).map do |img|
          uri = URI(img.get("src"))

          "#{uri.scheme}://#{uri.hostname}/press/img/#{uri.path.split("/").last}"
        end
      end

      def header_image
        page.at_css("div.m-article-eyecatch img")
      end

      def content_images
        page.css("div.m-article-main img.size-full")
      end
    end
  end
end
