module Ocawari
  module Strategy
    class Sirabee < Parser

      private

      LARGEST_KNOWN_WIDTH = 768
      LARGEST_KNOWN_HEIGHT = 512

      def parse
        if has_gallery_images?
          page.css("div.entryGallery div.entryGallery-item img").map do |img|
            img["src"].sub(/-\d{3}x\d{3}/, "-#{LARGEST_KNOWN_WIDTH}x#{LARGEST_KNOWN_HEIGHT}")
          end
        else
          page.css("article.entryContent section.entryContentBody img.size-large").map do |img|
            img["src"]
          end
        end
      end

      private

      def has_gallery_images?
        page.css("div.entryGallery div.entryGallery-item img").any?
      end
    end
  end
end
