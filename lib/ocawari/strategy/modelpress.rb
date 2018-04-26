module Ocawari
  module Strategy
    class ModelPress < Parser

      private

      CSS_SELECTORS = [
        "div#body-top img.outputthumb",
        "article.mdpr-article img.outputthumb"
      ]

      def parse
        image_links = page.css(CSS_SELECTORS.join(", ")).map { |img| img["src"] }

        image_links.map do |link|
          link, _query_params = link.split("?")

          # width is 6000 to make Fastly return
          # the largest image possible
          "#{link}?width=6000&quality=100"
        end
      end
    end
  end
end
