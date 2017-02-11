module Ocawari
  module Strategy
    class Hustlepress < Parser

      private

      CSS_SELECTORS = [
        "div.post_content img.size-full"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |img|
          img.get("src")
        end
      end
    end
  end
end
