module Ocawari
  module Strategy
    Twitter = lambda do |uri|
      page = Oga.parse_html(uri.open.read)
      css_selector_hierarchy = %w(
        div.permalink-tweet-container
        div.tweet
        div.AdaptiveMedia-photoContainer
        img
      ).join(" ")

      image_nodes = page.css(css_selector_hierarchy)

      image_nodes.map do |img|
        "#{img.get("src")}:large"
      end.uniq
    end
  end
end
