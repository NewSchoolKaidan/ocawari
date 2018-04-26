module Ocawari
  module Strategy
    class GooglePlus < Parser
      def initialize(uri)
        if USER_IDENTIFIER.match?(uri.to_s)
          @uri = Addressable::URI.parse(uri.to_s.sub(USER_IDENTIFIER, ""))
        else
          @uri = uri
        end

        @page = Nokogiri::HTML(open(uri).read)
      rescue OpenURI::HTTPError
        @page = nil
      end

      private

      USER_IDENTIFIER = /\/u\/\d+\//

      def parse
        album_data_div = page.css("div").find do |div|
          /photos\/\d+\/albums\/\d+/.match?(div["jsdata"])
        end

        album_href = album_data_div["jsdata"].
          split(";").
          find { |data| /photos\/\d+\/albums\/\d+/.match?(data) }

        user_id = uri.to_s[/(\d+)/, 1]
        album_id = album_href[/albums\/(\d+)/, 1]

        picasa_url = %W(
          https://picasaweb.google.com
          data/feed/api
          user/#{user_id}
          albumid/#{album_id}
        ).join("/")

        picasa = Nokogiri::XML(
          open(Addressable::URI.parse(picasa_url)).read
        )
                              
        content_nodes = picasa.css("//entry/content") # not sure why #xpath wouldn't work but #css does

        content_nodes.map do |content|
          url = content["src"]
          url.split("/").insert(-2, "s0").join("/")
        end
      end
    end
  end
end