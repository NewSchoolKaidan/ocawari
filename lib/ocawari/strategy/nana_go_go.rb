module Ocawari
  module Strategy
    class NanaGoGo < Parser

      private

      def parse
        page.
          css("div.TalkPostDetail__media img").
          map do |img|

            img.get("src")
          end
      end
    end
  end
end
