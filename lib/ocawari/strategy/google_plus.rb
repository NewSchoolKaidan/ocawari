module Ocawari
  module Strategy
    GooglePlus = lambda do |uri|
      page = Oga.parse_html(uri.open.read)

      album_href = page.css("a").find do |a|
        a.get("href") =~ /photos\/\d+\/albums\/\d+/
      end.get("href")

      user_id = uri.to_s[/(\d+)/, 1]
      album_id = album_href[/albums\/(\d+)/, 1]

      picasa_url = %W(
        https://picasaweb.google.com
        data/feed/api
        user/#{user_id}
        albumid/#{album_id}
      ).join("/")

      picasa = Oga.parse_xml(URI(picasa_url).open.read)

      content_nodes = picasa.xpath("//entry/content")

      content_nodes.map do |content|
        url = content.get("src")
        url.split("/").insert(-2, "s0").join("/")
      end
    end
  end
end
