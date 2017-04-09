module Ocawari
  module Strategy
    class TvTokyo < Parser

      private

      CSS_SELECTORS = [
        "div.txyomu_articleContent img.mt-image-center"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |image|
          File.join("www.tv-tokyo.co.jp", image["src"])
        end
      end
    end
  end
end
