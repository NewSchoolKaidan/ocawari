module Ocawari
  module Strategy
    class Twitter < Parser

      private

      CSS_SELECTORS = [        
        "div.permalink-tweet-container div.tweet div.AdaptiveMedia-photoContainer img"
      ]

      def parse
        image_nodes = page.css(CSS_SELECTORS.join(" "))

        image_nodes.map do |img|
          "#{img["src"]}:large"
        end.uniq
      end
    end
  end
end
