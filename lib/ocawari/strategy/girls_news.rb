module Ocawari
  module Strategy
    class GirlsNews < Parser

      private

      CSS_SELECTORS = [
        "div#img_field div.single_img_field_l a",
        "div#img_field ul li.single_img_field_s a"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |a|
          File.join("http://www.stereosound.co.jp", a["href"])
        end
      end
    end
  end
end
