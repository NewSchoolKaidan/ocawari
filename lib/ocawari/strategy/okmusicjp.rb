module Ocawari
  module Strategy
    class OkMusicJP < Parser

      private

      CSS_SELECTORS = [
        "div#page_frame div.center-page_box div.head-img_box img",
        "div#page_frame div.center-page_box img.main-text_image"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |img|
          img["src"]
        end
      end
    end
  end
end
