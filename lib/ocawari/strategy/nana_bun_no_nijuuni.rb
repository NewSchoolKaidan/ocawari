module Ocawari
  module Strategy
    class NanaBunNoNijuuni < Parser

      private

      CSS_SELECTORS = [
        "div.blog_main img"
      ]

      def parse
        page.css(CSS_SELECTORS.join(",")).map do |img|
          File.join("http://blog.nanabunnonijyuuni.com", img["src"])
        end
      end
    end
  end
end