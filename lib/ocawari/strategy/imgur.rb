module Ocawari
  module Strategy
    class Imgur < Parser

      private

      def parse
        image_links = page.css("div.post-images a.zoom")

        image_links.map { |img| "http:#{img["href"]}" }
      end
    end
  end
end
