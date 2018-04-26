module Ocawari
  module Strategy
    class NanaGoGo < Parser

      private

      def parse
        img = page.css("img").find { |img| img["alt"] == "投稿画像" }

        if target_img = page.at("img[alt='投稿画像']")
          [target_img["data-src"]]
        else
          []
        end
      end
    end
  end
end
