module Ocawari
  module Strategy
    class SmartFlash < Parser

      private

      CSS_SELECTOR_HIERARCHY = %w(
        div#main
        div.section
        div.inner
        img
      ).join(" ")

      def parse
        page.css(CSS_SELECTOR_HIERARCHY).map do |img|
          img.get("src")
        end.select do |url|
          url =~ /data\.smart-flash\.jp/
        end
      end
    end
  end
end
