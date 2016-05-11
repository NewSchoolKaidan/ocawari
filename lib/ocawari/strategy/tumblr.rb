module Ocawari
  module Strategy
    Tumblr = lambda do |url|
      page = Oga.parse_html(open(url))
      image_filter_expression = /\d_(250|400|500|540|1280)\.jpg$/

      target_images = page.css("img").select do |img|
        img.get("src") =~ image_filter_expression
      end

      if target_images.any?
        image_urls = target_images.map { |img| img.get("src") }
      else
        iframe = page.css("iframe").find do |iframe|
          iframe.attributes.map(&:value).any? do |value|
            value =~ /photoset/
          end
        end

        page = Oga.parse_html(open(iframe.get("src")))
        target_images = page.css("img").select do |img|
          img.get("src") =~ image_filter_expression
        end

        image_urls = target_images.map { |img| img.get("src") }
      end


      lower_resolution = /(250|400|540|500)\.jpg/
      image_urls.map do |url|
        if url =~ lower_resolution
          url.sub(lower_resolution, "1280.jpg").strip
        else
          url.strip
        end
      end
    end
  end
end
