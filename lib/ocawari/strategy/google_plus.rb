module Ocawari
  module Strategy
    class GooglePlus < Parser
      def initialize(uri)
        if USER_IDENTIFIER.match?(uri.to_s)
          @uri = Addressable::URI.parse(uri.to_s.sub(USER_IDENTIFIER, ""))
        else
          @uri = uri
        end

        @page = Nokogiri::HTML(open(@uri).read)
      rescue OpenURI::HTTPError
        @page = nil
      end

      private

      USER_IDENTIFIER = /u\/\d+\//

      def parse
        album_url = File.join("https://plus.google.com", @page.to_html[/(\/photos\/\d+\/albums\/\d+)/, 1])
        album_page = Nokogiri::HTML(open(album_url).read)

        images = album_page.css("img").map do |img|
          img["src"].sub(/=w\d+-h\d+/, "=s0")
        end
      end
    end
  end
end