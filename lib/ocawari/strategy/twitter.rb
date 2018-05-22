module Ocawari
  module Strategy
    class Twitter < Parser
      def initialize(uri)
        @uri = uri
        @page = Nokogiri::HTML(
          open(uri, {"User-Agent" => Ocawari::WINDOWS_CHROME_USER_AGENT}).read
        )

      rescue OpenURI::HTTPError
        @page = nil
      end

      private

      CSS_SELECTORS = [        
        "div.permalink-tweet-container div.tweet div.AdaptiveMedia-photoContainer img"
      ]

      def parse
        image_nodes = page.css(CSS_SELECTORS.join(","))

        image_nodes.map do |img|
          "#{img["src"]}:large"
        end.uniq
      end
    end
  end
end
