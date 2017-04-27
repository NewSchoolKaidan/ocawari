module Ocawari
  module Strategy
    class NikkanSports < Parser

      private

      CSS_SELECTORS = [
        "article#columnMain div.column-photo-area img"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |image|
          path = image["style"].
                   sub("background-image: url(", "").
                   sub(/\);.*$/, "")

          File.join("www.nikkansports.com", path)
        end
      end
    end
  end
end
