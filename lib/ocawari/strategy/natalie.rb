module Ocawari
  module Strategy
    class Natalie < Parser

      private

      CSS_SELECTORS = [
        "div.NA_articleUnit ul.NA_imageList span.NA_thumb"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |image|
          image["data-bg"].sub(/fit_\d+x\d+/, "fixw_730_hq")
        end
      end
    end
  end
end
