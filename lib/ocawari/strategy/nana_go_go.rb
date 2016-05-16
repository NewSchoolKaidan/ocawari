module Ocawari
  module Strategy
    NanaGoGo = lambda do |uri|
      page = Oga.parse_html(uri.open.read)
      page.
        css("div.TalkPostDetail__media img").
        map do |img|

        img.get("src")
      end
    end
  end
end
