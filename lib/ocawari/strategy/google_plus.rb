module Ocawari
  module Strategy
    class GooglePlus < Parser

      private

      def parse
        album_data_div = page.css("div").find do |div|
          div.get("jsdata") =~ /photos\/\d+\/albums\/\d+/
        end

        album_href = album_data_div.
          get("jsdata").
          split(";").
          find { |data| data =~ /photos\/\d+\/albums\/\d+/ }

        user_id = uri.to_s[/(\d+)/, 1]
        album_id = album_href[/albums\/(\d+)/, 1]

        picasa_url = %W(
          https://picasaweb.google.com
          data/feed/api
          user/#{user_id}
          albumid/#{album_id}
        ).join("/")

        picasa = Oga.parse_xml(
          open(Addressable::URI.parse(picasa_url)).read
        )

        content_nodes = picasa.xpath("//entry/content")

        content_nodes.map do |content|
          url = content.get("src")
          url.split("/").insert(-2, "s0").join("/")
        end
      end
    end
  end
end
