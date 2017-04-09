module Ocawari
  module Strategy
    class Keyakizaka46 < Parser
      def initialize(uri)
        @uri = uri
        @page = Nokogiri::HTML(
          open(uri, {"User-Agent" => Ocawari::WINDOWS_CHROME_USER_AGENT}).read
        )

      rescue OpenURI::HTTPError
        @page = nil
      end

      private

      def parse
        page.css("div.box-article img").map do |img|
          File.join("http://www.keyakizaka46.com", img["src"])
        end
      end
    end
  end
end
