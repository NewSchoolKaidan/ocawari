module Ocawari
  module Strategy
    class Twitter < Parser

      private

      CSS_SELECTOR_HIERARCHY = %w(
        div.permalink-tweet-container
        div.tweet
        div.AdaptiveMedia-photoContainer
        img
      ).join(" ")

      def parse
        image_nodes = page.css(CSS_SELECTOR_HIERARCHY)

        image_nodes.map do |img|
          "#{img.get("src")}:large"
        end.uniq
      end
    end
  end
end
