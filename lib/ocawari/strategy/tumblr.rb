module Ocawari
  module Strategy
    class Tumblr < Parser

      private
      
      IMAGE_FILTER_EXPRESSION = /\d_(250|400|500|540|1280)\.jpg$/
      LOWER_RESOLUTION = /(250|400|540|500)\.(jpg|png)/
      OPENGRAPH_COMMENTS = [
        "BEGIN TUMBLR FACEBOOK OPENGRAPH TAGS",
        "FACEBOOK OPEN GRAPH"
      ]

      def parse
        if page.to_xml =~ /(#{OPENGRAPH_COMMENTS.join("|")})/
          target_images = page.css("meta[property='og:image']")
        else
          target_images = page.css("img").select do |img|
            img["src"] =~ IMAGE_FILTER_EXPRESSION
          end
        end

        if target_images.any?
          image_urls = target_images.flat_map do |node|
            [node["content"], node["src"]]
          end.compact
        else
          iframe = page.css("iframe").find do |iframe|
            iframe.attributes.values.any? do |v|
              v.value =~ /photoset/
            end
          end

          return [] unless iframe

          @page = Nokogiri::HTML(open(iframe["src"]))
          target_images = page.css("img").select do |img|
            img["src"] =~ IMAGE_FILTER_EXPRESSION
          end

          image_urls = target_images.map { |img| img["src"] }
        end


        image_urls.map do |url|
          if url =~ LOWER_RESOLUTION
            url.sub(
              LOWER_RESOLUTION, 
              "1280#{File.extname(url)}"
            ).strip
          else
            url.strip
          end
        end
      end
    end
  end
end
