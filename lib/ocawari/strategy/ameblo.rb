module Ocawari
  module Strategy
    class Ameblo < Parser

      private

      def parse
        image_nodes = page.css("article a.detailOn img")

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
