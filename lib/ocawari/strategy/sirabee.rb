module Ocawari
  module Strategy
    class Sirabee < Parser

      private

      CSS_SELECTORS = [
        "article#entry section.entryContent img.size-large"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |image|
          "http://#{image.get("src").sub(/^\/\//, "")}"
        end
      end
    end
  end
end
