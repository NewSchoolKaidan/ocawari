module Ocawari
  module Strategy
    class TokyoIdolNet < Parser

      private

      def parse
        page.css("img").map do |img|
          img["data-large-file"]
        end.compact
      end
    end
  end
end
