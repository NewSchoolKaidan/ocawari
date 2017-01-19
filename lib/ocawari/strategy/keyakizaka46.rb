module Ocawari
  module Strategy
    class Keyakizaka46 < Parser
      def initialize(uri)
        @uri = uri
        @page = Oga.parse_html(
          open(uri, {
              "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
            }
          ).read
        )

      rescue OpenURI::HTTPError
        @page = nil
      end
      
      private

      def parse
        page.css("div.box-article img").map do |img|
          File.join("http://www.keyakizaka46.com", img.get("src"))
        end
      end
    end
  end
end
