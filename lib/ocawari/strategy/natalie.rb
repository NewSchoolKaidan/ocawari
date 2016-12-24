module Ocawari
  module Strategy
    class Natalie < Parser

      private

      CSS_SELECTORS = [
        "div.NA_articleUnit ul.NA_imageList span.NA_thumb"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |image|
          style = image.get("style")
          url_fragment = style.
            sub("background-image: url(", "").
            sub(");", "").
            sub("list_thumb_inbox_", "xlarge_")

          "http://cdn2.natalie.mu#{url_fragment}"
        end
      end
    end
  end
end
