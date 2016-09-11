module Ocawari
  module Strategy
    class Line < Parser

      private

      CSS_SELECTOR_HIERARCHY = %w(
        div.article-body
        div.article-body-inner
        img.pict
      ).join(" ")

      def parse
        image_nodes = page.css(CSS_SELECTOR_HIERARCHY)

        image_nodes.map do |img|
          imgname = img.get("src")
          imgname.sub("-s.", "#{File.extname(imgname)}")
        end
      end
    end
  end
end
