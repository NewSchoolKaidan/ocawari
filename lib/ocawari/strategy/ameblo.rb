module Ocawari
  module Strategy
    class Ameblo < Parser

      private

      def parse
        image_nodes = page.css("article a.detailOn img")

        image_nodes.map { |img| img.get("src") }
      end
    end
  end
end
