module Ocawari
  module Strategy
    Instagram = lambda do |uri|
      if uri.path =~ /\?taken-by=/
        uri.path = uri.path.sub(/\/\?taken-by=.*/, "")
        page = Oga.parse_html(uri.open.read)
      else
        page = Oga.parse_html(uri.open.read)
      end

      meta_node_with_image = page.at_css("meta[property='og:image']")
      image = meta_node_with_image.get("content")

      [image]
    end
  end
end
