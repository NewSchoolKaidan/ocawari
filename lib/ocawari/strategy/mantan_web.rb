module Ocawari
  module Strategy
    class MantanWeb < Parser

      private

      CSS_SELECTORS = [
        "ul.newsbody__thumblist li.newsbody__thumb img"
      ]

      def parse
        amount_of_images = page.at_css("span.newsbody__photo-num").text.to_i
        main_image = page.at_css("div.newsbody__img img").get("src")

        (1..amount_of_images).to_a.map do |i|
          if i < 10
            main_image.sub("001_size6", "00#{i}_size10")
          elsif i >= 10 && i < 100
            main_image.sub("001_size6", "0#{i}_size10")
          elsif i >= 100 && i < 1000
            main_image.sub("001_size6", "#{i}_size10")
          end
        end
      end
    end
  end
end
