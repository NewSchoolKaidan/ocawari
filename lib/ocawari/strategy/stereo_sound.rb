module Ocawari
  module Strategy
    class StereoSound < Parser

      private

      CSS_SELECTORS = [
        "div#addBlogArticleArea p.addPhoto a",
        "div#addBlogArticleArea p.addIdolPhoto a"
      ]

      def parse
        page.css(CSS_SELECTORS.join(", ")).map do |a|
          File.join("http://www.stereosound.co.jp", a.get("href"))
        end
      end
    end
  end
end
