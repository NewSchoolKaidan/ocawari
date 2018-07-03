module Ocawari
  module Strategy
    class NewsDwango < Parser

      private

      CSS_SELECTORS = [
        "#js-fancy-slider-sub img"
      ]

      def parse
        page.css(CSS_SELECTORS.join(",")).map do |img|
          img["src"].sub("/lg_", "/")
        end
      end
    end
  end
end
