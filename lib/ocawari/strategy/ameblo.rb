module Ocawari
  module Strategy
    class Ameblo < Parser

      private

      CSS_HIERARCHY_SELECTORS = [
        "article a.detailOn img",
        "div.subContentsInner a.detailOn img"
      ]

      def parse
        image_nodes = page.css(CSS_HIERARCHY_SELECTORS.join(", "))

        image_nodes.map do |img|
          image_source = img.get("src")
          case image_source
          when /t\d+_/
            image_source.sub(/t\d+_/, "o")
          when /\?caw=800$/
            image_source.sub(/\?caw=800/, "")
          else
            image_source
          end
        end
      end
    end
  end
end
