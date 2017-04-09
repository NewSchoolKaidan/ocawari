module Ocawari
  module Strategy
    class MensFashion < Parser

      private

      CSS_SELECTORS = [
        "p img.size-full",
        "img.image_ll",
        "img.image_ls"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |img|
          img["src"]
        end
      end
    end
  end
end
