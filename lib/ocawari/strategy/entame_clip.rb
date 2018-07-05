module Ocawari
  module Strategy
    class EntameClip < Parser

      private

      CSS_SELECTORS = [
        "div#the-content div.hover-image a"
      ]

      def parse
        page.css(CSS_SELECTORS.join(",")).map do |a|
          a["href"]
        end
      end
    end
  end
end
