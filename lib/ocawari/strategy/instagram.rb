module Ocawari
  module Strategy
    Instagram = lambda do |url|
      if url =~ /\?taken-by=/
        scrubbed_url = url.sub(/\/\?taken-by=.*/, "")
        page = Oga.parse_html(open(scrubbed_url))
      else
        page = Oga.parse_html(open(url))
      end

      meta_node_with_image = page.at_css("meta[property='og:image']")
      image = meta_node_with_image.get("content")

      [image]
    end
  end
end
