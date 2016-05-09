module Ocawari
  module Strategy
    Twitter = lambda do |url|
      page = Oga.parse_html(open(url))
      css_selector_hierarchy = %w(
        div.permalink-tweet-container
        div.tweet
        div.AdaptiveMedia-photoContainer
        img
      ).join(" ")

      image_nodes = page.css(css_selector_hierarchy)

      image_nodes.map { |img| "#{img.get("src")}:large" }.uniq
    end
  end
end
